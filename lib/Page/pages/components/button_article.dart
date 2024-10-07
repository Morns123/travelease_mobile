import 'package:flutter/material.dart';

class ButtonArticle extends StatelessWidget {
  final String title;
  final Border border;
  final VoidCallback onTap;

  const ButtonArticle({
    super.key,
    required this.onTap,
    required this.title,
    required this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, border: border),
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xff000000),
          ),
        ),
      ),
    );
  }
}
