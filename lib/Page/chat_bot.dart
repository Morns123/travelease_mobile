import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelease_mobile/Page/DetailReport.dart';
import 'package:travelease_mobile/Page/ReportPage.dart';
class ChatMessage {
  String messageContent;
  String messageType;
  bool isCategoryList; 

  ChatMessage({
    required this.messageContent,
    required this.messageType,
    this.isCategoryList = false, 
  });
}
class Category {
  final int id;
  final String name;
  final String description;

  Category({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name_category'],
      description: json['description'],
    );
  }
}


class ChatBot extends StatefulWidget {
  final String token;

    const ChatBot({Key? key,  required this.token}) : super(key: key);



  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
   List<Map<String, dynamic>> _messages = [];
     List<Category> categories = [];
     
     late String token;
  String _currentQuestion = "Saya di sini untuk membantu Anda dengan segala kebutuhan perjalanan Anda. Jika Anda memiliki pertanyaan atau memerlukan bantuan, silakan beri tahu saya!";
  final TextEditingController _textController = TextEditingController();
   final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String selectedPriority = 'low';
  int? selectedCategoryId;
  int chatcs = 0;


  @override
  void initState() {
    super.initState();
    _getInitialNodes();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final token = widget.token;

      final response = await http.get(
        Uri.parse('http://192.168.1.10:8000/api/categories'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true) {
          setState(() {
            categories = (data['data'] as List)
                .map((category) => Category.fromJson(category))
                .toList();
          });
        }
      }
    } catch (e) {
      print('Error loading categories: $e');
    }
  }

  Future<void> _getInitialNodes() async {
    final response = await http.get(Uri.parse('http://192.168.1.10:8000/api/conversation/initial'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _currentQuestion = data['data']['question'];
        _messages.add({
          'type': 'bot',
          'message': _currentQuestion,
          'options': data['data']['nodes']
        });
      });
    } else {
      setState(() {
        _messages.add({'type': 'bot', 'message': 'Error fetching data from server.'});
      });
    }
  }

  Future<void> _getChildNodes(int parentId, String buttonText) async {
    setState(() {
      _messages.add({'type': 'user', 'message': buttonText});
    });

    final response = await http.get(Uri.parse('http://192.168.1.10:8000/api/conversation/children/$parentId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        if (data['data']['nodes'] != null && data['data']['nodes'].isNotEmpty) {
          _currentQuestion = data['data']['question'];
          _messages.add({
            'type': 'bot',
            'message': data['data']['question'],
            'options': data['data']['nodes'],
          });
        } else {
          _messages.add({'type': 'bot', 'message': data['data']['answer']});
          chatcs++;
          if (chatcs >= 2) {
            // Tampilkan tombol setelah 2 kali pengulangan
            setState(() {});
          }
          Future.delayed(Duration(seconds: 1), () {
            _getInitialNodes();
          });
        }
      });
    } else {
      setState(() {
        _messages.add({'type': 'bot', 'message': 'Error fetching child nodes.'});
      });
    }
  }





  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // sama bae kek di detailchat
  void _sendMessage() {
    String userMessage = _textController.text.trim();
    if (userMessage.isNotEmpty) {
      setState(() {
        _messages.add({'type': 'user', 'message': userMessage});
        _messages.add({
          'type': 'bot',
          'message': 'Mohon maaf saya tidak mengerti maksud Anda, silakan pilih dari opsi yang sudah disediakan.'
        });
        // Mengulangi pertanyaan terakhir yang dibahas
        _messages.add({
          'type': 'bot',
          'message': _currentQuestion,
          'options': _messages.lastWhere((msg) => msg['type'] == 'bot' && msg['options'] != null)['options']
        });
      });
      _textController.clear();
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      leadingWidth: 400,
        backgroundColor: Color(0xFF3C729A),
        leading: Row(
          children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Container(
                margin: EdgeInsets.only(bottom: 12),
                child: CircleAvatar(
                  radius: 25, 
                  backgroundImage: NetworkImage("https://randomuser.me/api/portraits/women/44.jpg"), 
                ),
              ),
              SizedBox(width: 10,),
              Container(
                margin: EdgeInsets.only(bottom: 12),
                child: Text("BOT EZ",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 238, 238, 238),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: _messages.length,
            padding: EdgeInsets.only(top: 10, bottom: 60),
            itemBuilder: (context, index) {
              final messages = _messages[index];
             if (messages['options'] != null) {
                return _buildOptionList(messages); // render list option
              } else {
                return _buildMessageBubble(messages);
              }
            },
          ),
           if (chatcs >= 2) 
          Column(mainAxisAlignment: MainAxisAlignment.end,
           children: [
             Container(margin: EdgeInsets.only(bottom: 70, left: 15),
              height: 30,
              width: 70,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF3C729A), width: 1.0), 
                  borderRadius: BorderRadius.circular(15), 
                ),
                child: FloatingActionButton(
                  heroTag: chatcs,
                  onPressed: _showCreateTicketDialog,
                  child: Text(
                    "Chat CS",
                    style: TextStyle(
                      color: Color(0xFF3C729A), 
                    ),
                  ),
                  backgroundColor: Colors.white, 
                  elevation: 0, 
                ),
              ),
           ],
         ),
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
                      controller: _textController,
                      decoration: InputDecoration(
                          hintText: "Tulis pesan di sini...",
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none),
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

  // Widget sama be
  Widget _buildMessageBubble(Map<String, dynamic> message) {
    return Container(
      padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
        alignment: message['type'] == 'bot' ? Alignment.topLeft : Alignment.topRight,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: message['type'] == 'bot' ? Colors.grey.shade200 : const Color.fromARGB(255, 112, 177, 242),
          ),
          padding: EdgeInsets.all(16),
          child: Text(
            message['message'],
            style: TextStyle(
              fontSize: 15,
              color: message['type'] == 'bot' ? Colors.black : const Color.fromARGB(255, 255, 255, 255),
              ),
          ),
        ),
      ),
    );
  }

  // widget tampilan list option
  Widget _buildOptionList(Map<String, dynamic> message) {
    final options = message['options'] as List<dynamic>;
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
             message['message'],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Divider(),
          ...options.map((options) {
            return _buildOption(context, options['button_text'], options['id']);
          })
        ],
      ),
    );
  }

  // metod nya
  Widget _buildOption(BuildContext context, String text,  int nodeId) {
    return InkWell(
      onTap: () {
          _getChildNodes(nodeId, text);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

    void _showCreateTicketDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Buat Tiket Baru'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Judul',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Deskripsi',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedPriority,
                      decoration: InputDecoration(
                        labelText: 'Prioritas',
                        border: OutlineInputBorder(),
                      ),
                      items: ['low', 'medium', 'high'].map((String priority) {
                        return DropdownMenuItem<String>(
                          value: priority,
                          child: Text(priority.toUpperCase()),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedPriority = value ?? 'low';
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<int>(
                      value: selectedCategoryId,
                      decoration: InputDecoration(
                        labelText: 'Kategori',
                        border: OutlineInputBorder(),
                      ),
                      items: categories.map((Category category) {
                        return DropdownMenuItem<int>(
                          value: category.id,
                          child: Text(category.name),
                        );
                      }).toList(),
                      onChanged: (int? value) {
                        setState(() {
                          selectedCategoryId = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Batal'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3C729A),
                  ),
                  onPressed: () => _createTicket(context),
                  child: Text(
                    'Buat Tiket',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }




    Future<void> _createTicket(BuildContext context) async {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Semua field harus diisi')),
      );
      return;
    }

    try {
      final token = widget.token;

      final response = await http.post(
        Uri.parse('http://192.168.1.10:8000/api/tickets'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'title': titleController.text,
          'description': descriptionController.text,
          'priority': selectedPriority,
          'category_id': selectedCategoryId,
        }),
      );

      final data = jsonDecode(response.body);

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          data['status'] == true) {
            
        // Clear form
        titleController.clear();
        descriptionController.clear();
        selectedPriority = 'low';
        selectedCategoryId = null;

        Navigator.push(context, MaterialPageRoute(builder: (context) => ReportPage(onCategorySelected:  (int) { }, token: token)));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tiket berhasil dibuat')),
        );
      } else {
        throw Exception(data['message'] ?? 'Failed to create ticket');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }


}

class CategoryItem extends StatelessWidget {
 final String categoryName;
 final Function(String) onClick;
 final Color backgroundColor; 

 const CategoryItem({
  Key? key,
  required this.categoryName,
  required this.onClick,
  required this.backgroundColor, 
 }) : super(key: key);

 @override
 Widget build(BuildContext context) {
  return Padding(
   padding: const EdgeInsets.symmetric(horizontal: 8.0),
   child: ElevatedButton(
    onPressed: () {
     onClick(categoryName);
    },
    style: ElevatedButton.styleFrom(
     backgroundColor: backgroundColor, 
     shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
     ),
    ),
    child: Text(
     categoryName,
     style: TextStyle(color: Colors.white),
    ),
   ),
  );
 }
}