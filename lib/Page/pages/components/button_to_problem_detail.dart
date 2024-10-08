import 'package:flutter/material.dart';

class ButtonToProblemDetail extends StatelessWidget {
  final Size size;
  final Color color;
  final String title;
  final VoidCallback onPressed;
  final OutlinedBorder outlinedBorder;
  const ButtonToProblemDetail({
    super.key,
    required this.size,
    required this.color,
    required this.title,
    required this.onPressed,
    required this.outlinedBorder,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        minimumSize: WidgetStatePropertyAll(size),
        shape: WidgetStatePropertyAll(outlinedBorder),
        backgroundColor: WidgetStatePropertyAll(color),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color(0xff000000),
          ),
        ),
      ),
    );
  }
}
