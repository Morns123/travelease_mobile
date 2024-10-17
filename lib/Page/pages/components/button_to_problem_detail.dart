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
    return Container(
      height: 40,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 159, 159, 159))
      ),
        
          child: Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w500,
                color: Color(0xff000000),
              ),
            ),
          ),
      
      );
   
  }
}
