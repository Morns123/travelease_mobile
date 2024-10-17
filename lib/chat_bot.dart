import 'package:flutter/material.dart';

class ChatMessage {
  String messageContent;
  String messageType;
  bool isOptionList;
  bool isCategoryList; 

  ChatMessage({
    required this.messageContent,
    required this.messageType,
    this.isOptionList = false,
    this.isCategoryList = false, 
  });
}

class ChatBot extends StatefulWidget {
  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  List<ChatMessage> messages = [
    ChatMessage(
      messageContent:
          "Saya di sini untuk membantu Anda dengan segala kebutuhan perjalanan Anda. Jika Anda memiliki pertanyaan atau memerlukan bantuan, silakan beri tahu saya!",
      messageType: "receiver",
    ),
    ChatMessage(
      messageContent: "Berikut adalah pertanyaan terkait Refund:",
      messageType: "receiver",
      isOptionList: true,
    ),
    ChatMessage(
      messageContent: "Pilih kategori yang tersedia:",
      messageType: "receiver",
      isCategoryList: true,
    ),
  ];


  final List<String> categories = [
    "Pemesanan",
    "Pembayaran",
    "Refund",
    "Destinasi",
  ];

  final List<Color> categoryColors = [
  Colors.blue,
  Colors.green,
  Colors.red, 
  Colors.orange, 
  ];

  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // sama bae kek di detailchat
  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add(ChatMessage(
          messageContent: _controller.text,
          messageType: "sender",
        ));
        _controller.clear();
      });
    }
  }

  // metod untuk simulasi in saat ngeklik opsion nya
  void _selectOption(String selectedOption) {
    setState(() {
      messages.add(ChatMessage(messageContent: selectedOption, messageType: "sender"));
      messages.add(ChatMessage(
        messageContent:
        // ini balesannya (cuma contoh)
            "Proses pengembalian uang tiket biasanya memerlukan waktu 5 hingga 14 hari kerja, tergantung pada metode pembayaran yang Anda gunakan.",
        messageType: "receiver",
      ));
    });
  }

  // umpan balik category
  void _onCategoryClick(String categoryName) {
    setState(() {
      messages.add(ChatMessage(messageContent: categoryName, messageType: "sender"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3C729A),
        leadingWidth: 2,
        leading: Row(
          children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(width: 1),
              CircleAvatar(
                radius: 25, 
                backgroundImage: NetworkImage("https://randomuser.me/api/portraits/women/44.jpg"), 
              ),
              SizedBox(width: 10,),
              Text("BOT EZ",
                style: TextStyle(
                  color: const Color.fromARGB(255, 238, 238, 238),
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: messages.length,
            padding: EdgeInsets.only(top: 10, bottom: 60),
            itemBuilder: (context, index) {
              if (messages[index].isOptionList) {
                return _buildCategoryList(); // render list category 
              } else if (messages[index].isCategoryList) {
                return _buildOptionList(); // render list option
              } else {
                return _buildMessageBubble(messages[index]);
              }
            },
          ),
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
                  onPressed: () {},
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
                      controller: _controller,
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

  // widget tampilan list option
  Widget _buildOptionList() {
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
            "Silahkan pilih topik sesuai yang ingin kamu tanyakan",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Divider(),
          _buildOption(context, "Apa metode pembayaran yang diterima untuk pemesanan tiket?", _selectOption),
          Divider(),
          _buildOption(context, "Bagaimana cara mengubah pemesanan tiket yang sudah saya buat?", _selectOption),
          Divider(),
          _buildOption(context, "Apa yang harus saya lakukan jika saya tidak menerima konfirmasi refund setelah mengajukan permohonan?", _selectOption),
        ],
      ),
    );
  }

  // metod nya
  Widget _buildOption(BuildContext context, String text, Function(String) onClick) {
    return InkWell(
      onTap: () {
        onClick(text);
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

  // widget tampilan list kategori
  Widget _buildCategoryList() {
  return Container(
   height: 40,
   margin: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
   child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: categories.length,
    itemBuilder: (context, index) {
     return CategoryItem(
      categoryName: categories[index],
      onClick: _onCategoryClick,
      backgroundColor: categoryColors[index], 
     );
    },
   ),
  );
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
