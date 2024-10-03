import 'package:flutter/material.dart';
import 'pages/detail_problem_page/detail_problem.dart';
import 'pages/help_center_page/help_center.dart';
import 'pages/profile_page/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HelpCenterPage(),
        '/help_center': (context) => const HelpCenterPage(),
        '/profile': (context) => const ProfilePage(),
        '/detail_problem': (context) => const DetailProblemPage(),
      },
    );
  }
}
