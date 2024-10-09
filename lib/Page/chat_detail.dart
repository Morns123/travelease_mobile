import 'dart:async';
import 'package:flutter/material.dart';

class ChatMessage {
  String messageContent;
  String messageType;

  ChatMessage({required this.messageContent, required this.messageType});
}

class ChatDetailPage extends StatefulWidget {
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Halo, saya Meliana Putri! Saya di sini untuk membantu Anda dalam perjalanan Anda dengan aplikasi TravelEase. Apakah Anda memerlukan bantuan?", messageType: "receiver"),
    ChatMessage(messageContent: "Kg Butuh?", messageType: "receiver"),
    ChatMessage(messageContent: "Butuh lah! gilak kali kau", messageType: "sender"),
    ChatMessage(messageContent: "Apa sudah kau cepet ketikan", messageType: "receiver"),
    ChatMessage(messageContent: "Sabar mi", messageType: "sender"),
    ChatMessage(messageContent: "Halo, saya Meliana Putri! Saya di sini untuk membantu Anda dalam perjalanan Anda dengan aplikasi TravelEase. Apakah Anda memerlukan bantuan?", messageType: "receiver"),
    ChatMessage(messageContent: "Kg Butuh?", messageType: "receiver"),
    ChatMessage(messageContent: "Butuh lah! gilak kali kau", messageType: "sender"),
    ChatMessage(messageContent: "Apa sudah kau cepet ketikan", messageType: "receiver"),
    ChatMessage(messageContent: "Sabar mi", messageType: "sender"),
    ChatMessage(messageContent: "Halo, saya Meliana Putri! Saya di sini untuk membantu Anda dalam perjalanan Anda dengan aplikasi TravelEase. Apakah Anda memerlukan bantuan?", messageType: "receiver"),
    ChatMessage(messageContent: "Kg Butuh?", messageType: "receiver"),
    ChatMessage(messageContent: "Butuh lah! gilak kali kau", messageType: "sender"),
    ChatMessage(messageContent: "Apa sudah kau cepet ketikan", messageType: "receiver"),
    ChatMessage(messageContent: "Sabar mi", messageType: "sender"),
  ];

  TextEditingController _controller = TextEditingController();
  Timer? _hideButtonTimer;
  bool _isButtonVisible = true;
  bool _isChatClosed = true;

  @override
  void dispose() {
    _controller.dispose();
    _hideButtonTimer?.cancel();
    super.dispose();
  }

  // metod ngirim pesan baru/custom
  void _sendMessage() {
    if (_controller.text.isNotEmpty && !_isChatClosed) {
      setState(() {
        messages.add(ChatMessage(
          messageContent: _controller.text,
          messageType: "sender",
        ));
        _controller.clear();
      });
    }
  }

  void _onUserInteraction() {
    setState(() {
      _isButtonVisible = false;
    });

// ntuk hide in button
    _hideButtonTimer?.cancel();
    _hideButtonTimer = Timer(Duration(seconds: 2), () {
      setState(() {
        _isButtonVisible = true;
      });
    });
  }

  void _closeChat() {
    setState(() {
      _isChatClosed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onUserInteraction,
      onPanUpdate: (details) {
        _onUserInteraction();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            backgroundColor: Color(0xFF3C729A),
            leadingWidth: 94,
            leading: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 2),
                CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage("https://randomuser.me/api/portraits/women/44.jpg"),
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
                      "Meliana Putri",
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
                          color: _isChatClosed ? Colors.yellow : const Color.fromARGB(255, 40, 213, 45),
                          size: 12,
                        ),
                        SizedBox(width: 5),
                        Text(
                          _isChatClosed ? "Tertutup" : "Sedang Berlangsung",
                          style: TextStyle(
                            color: _isChatClosed ? Colors.yellow : Color.fromARGB(255, 40, 213, 45),
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
            ListView.builder(
              itemCount: messages.length,
              padding: EdgeInsets.only(top: 10, bottom: 60),
              itemBuilder: (context, index) {
                return _buildMessageBubble(messages[index]);
              },
            ),
          
          
          ],
        ),
      ),
    );
  }

  // Widget untuk chat-chatnya
  Widget _buildMessageBubble(ChatMessage message) {
    return Container(
      padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
        alignment: (message.messageType == "receiver" ? Alignment.topLeft : Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (message.messageType == "receiver" ? Colors.grey.shade200 : Colors.blue[200]),
          ),
          padding: EdgeInsets.all(16),
          child: Text(
            message.messageContent,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
