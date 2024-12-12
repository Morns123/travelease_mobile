import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelease_mobile/widget/ReportPage/SedangBerlangsung.dart';

class ChatMessage {
  final int id;
  final String message;
  final String createdAt;
  final Map<String, dynamic> user;
  final String messageType;

  ChatMessage({
    required this.id,
    required this.message,
    required this.createdAt,
    required this.user,
    required this.messageType,
  });

  factory ChatMessage.fromJson(
      Map<String, dynamic> json, String currentUserId) {
    return ChatMessage(
      id: json['id'],
      message: json['message'],
      createdAt: json['created_at'],
      user: json['user'],
      messageType: json['user']['id'].toString() == currentUserId
          ? "sender"
          : "receiver",
    );
  }
}

class ChatDetailPage extends StatefulWidget {
  final String token;
  final Ticket ticket;

  const ChatDetailPage({Key? key, required this.ticket, required this.token}) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  List<ChatMessage> messages = [];
  bool isLoading = true;
  late String? token;
  String? currentUserId;
  TextEditingController _controller = TextEditingController();
  Timer? _messageTimer;

  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _loadTokenAndMessages();
    if (widget.ticket.status != "closed") {
      _startMessagePolling();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _messageTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startMessagePolling() {
    _messageTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (!_isDisposed && mounted && widget.ticket.status != "closed") {
        _fetchMessages();
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _loadTokenAndMessages() async {
  if (_isDisposed) return;
    
    try {
      final prefs = await SharedPreferences.getInstance();
    token = widget.token;
      final userData = jsonDecode(prefs.getString('userData') ?? '{}');
      currentUserId = userData['id'].toString();
      await _fetchMessages();
    } catch (e) {
      print('Error loading token and messages: $e');
    }
  }

  Future<void> _fetchMessages() async {
    if (_isDisposed) return;

    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.145:8000/api/tickets/${widget.ticket.id}/messages'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (_isDisposed) return;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true) {
          final List<ChatMessage> loadedMessages = (data['data']['messages'] as List)
              .map((msg) => ChatMessage.fromJson(msg, currentUserId!))
              .toList();

          if (mounted && !_isDisposed) {
            setState(() {
              messages = loadedMessages;
              isLoading = false;
            });
          }
        }
      }
    } catch (e) {
      print('Error fetching messages: $e');
      if (mounted && !_isDisposed) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty || widget.ticket.status == "closed" || _isDisposed) return;

    final messageText = _controller.text;
    _controller.clear();

    final optimisticMessage = ChatMessage(
      id: -1,
      message: messageText,
      createdAt: DateTime.now().toIso8601String(),
      user: {'id': currentUserId, 'name': 'You', 'type': 'user'},
      messageType: "sender",
    );

    if (mounted && !_isDisposed) {
      setState(() {
        messages.add(optimisticMessage);
      });
    }

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.145:8000/api/tickets/${widget.ticket.id}/messages'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'message': messageText,
        }),
      );

      if (_isDisposed) return;

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['status'] == true) {
          final realMessage = ChatMessage(
            id: data['data']['id'],
            message: data['data']['message'],
            createdAt: data['data']['created_at'],
            user: data['data']['user'],
            messageType: "sender",
          );

          if (mounted && !_isDisposed) {
            setState(() {
              final index = messages.indexOf(optimisticMessage);
              if (index != -1) {
                messages[index] = realMessage;
              }
            });
          }
        } else {
          if (mounted && !_isDisposed) {
            setState(() {
              messages.remove(optimisticMessage);
            });
          }
          throw Exception(data['message'] ?? 'Failed to send message');
        }
      } else {
        if (mounted && !_isDisposed) {
          setState(() {
            messages.remove(optimisticMessage);
          });
        }
        throw Exception('Failed to send message');
      }
    } catch (e) {
      print('Error sending message: $e');
      if (mounted && !_isDisposed) {
        setState(() {
          messages.remove(optimisticMessage);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send message: ${e.toString()}'),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () => _resendMessage(messageText),
            ),
          ),
        );
      }
    }
  }

  Future<void> _resendMessage(String messageText) async {
    _controller.text = messageText;
    await _sendMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Color(0xFF3C729A),
          leadingWidth: 94,
          leading: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(width: 2),
              CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(
                    "https://randomuser.me/api/portraits/women/44.jpg"),
              ),
            ],
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Customer Service",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: widget.ticket.status == "closed"
                            ? Colors.red
                            : widget.ticket.status == "accepted"
                                ? Colors.green
                                : Colors.yellow,
                        size: 12,
                      ),
                      SizedBox(width: 5),
                      Text(
                        widget.ticket.status == "closed"
                            ? "Tertutup"
                            : widget.ticket.status == "accepted"
                                ? "Sedang Berlangsung"
                                : "Menunggu",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: messages.length,
                  padding: EdgeInsets.only(top: 10, bottom: 60),
                  itemBuilder: (context, index) {
                    return _buildMessageBubble(messages[index]);
                  },
                ),
          if (widget.ticket.status != "closed")
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 60,
                width: double.infinity,
                color: Color(0xFF3C729A),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 15),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: "Tulis pesan di sini...",
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 15),
                    FloatingActionButton(
                      onPressed: _sendMessage,
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 28,
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

Widget _buildMessageBubble(ChatMessage message) {
  // Ambil type dari user
  String userType = message.user['type']; // Pastikan 'type' ada di data user

  return Container(
    padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
    child: Align(
      // Sesuaikan posisi berdasarkan type user
      alignment: (userType == "user"
          ? Alignment.topRight  // User di kanan
          : Alignment.topLeft), // Admin/Officer di kiri
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: (userType == "user"
              ? Colors.blue[200]  // Warna untuk user
              : Colors.grey.shade200), // Warna untuk admin/officer
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.message,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 5),
            Text(
              message.user['name'], // Tampilkan nama user
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    ),
  );
}

}
