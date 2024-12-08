import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final IconData prefixIcon;

  final bool enabled;

  const MyTextField({
    required this.textEditingController,
    required this.prefixIcon,
    required this.enabled,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xff366389),
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: const Color(0xff366389),
        ),
        enabled: enabled,
      ),
    );
  }
}
