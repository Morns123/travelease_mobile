
import 'package:flutter/material.dart';
import 'package:travelease_mobile/Page/DetailReport.dart';
import 'package:travelease_mobile/Page/HomePage.dart';
import 'package:travelease_mobile/Page/ReportPage.dart';
import 'package:travelease_mobile/Page/chat_bot.dart';
import 'package:travelease_mobile/Page/chat_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
