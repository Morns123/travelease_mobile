import 'package:flutter/material.dart';
import 'package:travelease_mobile/chat_bot.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatBot() ,
    );
  }
}
 