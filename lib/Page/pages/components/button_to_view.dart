import 'package:flutter/material.dart';

class ButtonToView extends StatelessWidget {
  final Size size;
  final Color color;
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final OutlinedBorder outlinedBorder;
  const ButtonToView({
    super.key,
    required this.size,
    required this.icon,
    required this.color,
    required this.title,
    required this.onPressed,
    required this.outlinedBorder,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: WidgetStatePropertyAll(size),
        shape: WidgetStatePropertyAll(outlinedBorder),
        backgroundColor: WidgetStatePropertyAll(color),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xff000000),
            ),
          ),
          Icon(
            icon,
            color: const Color(0xff000000),
          ),
        ],
      ),
    );
  }
}
