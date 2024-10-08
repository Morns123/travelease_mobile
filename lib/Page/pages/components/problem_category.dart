import 'package:flutter/material.dart';

class ProblemCategory extends StatelessWidget {
  final VoidCallback onClick;
  final String text;
  const ProblemCategory({
    super.key,
    required this.onClick,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: ElevatedButton(
        onPressed: onClick,
        style: const ButtonStyle(
          minimumSize: WidgetStatePropertyAll(Size(90, 30)),
          backgroundColor: WidgetStatePropertyAll(Color(0xff6799C3)),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
