
import 'package:flutter/material.dart';
import 'package:travelease_mobile/Page/HomePage.dart';
import 'package:travelease_mobile/Page/chat_bot.dart';
import 'package:travelease_mobile/Page/chat_detail.dart';
import 'package:travelease_mobile/Page/login.dart';
import 'package:travelease_mobile/Page/pages/help_center_page/help_center.dart';
import 'package:travelease_mobile/Page/pages/profile_page/profile.dart';
import 'package:travelease_mobile/Page/register.dart';
import 'package:travelease_mobile/contoh/subs.dart';
import 'dart:io';


void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
} 
 



