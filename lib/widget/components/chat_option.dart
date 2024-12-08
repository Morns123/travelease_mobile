import 'package:flutter/material.dart';

class ChatOption extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  final Color? textColor;
  const ChatOption({
    super.key,
    required this.text,
    required this.onTap,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: ListTile(
        minTileHeight: 5,
        onTap: onTap,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: const Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
                size: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                text,
                style:  TextStyle(
                  fontSize: 13,
                  color: textColor,
                  fontFamily: "Montserrat-Bold",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
