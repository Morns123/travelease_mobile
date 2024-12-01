import 'package:flutter/material.dart';




class CustomKontent extends StatelessWidget {
  final String category;
  final String label;

  CustomKontent({required this.label, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color.fromRGBO(217, 217, 217, 1),
            width: 0.5,
          ),
          bottom: BorderSide(color: Color.fromRGBO(217, 217, 217, 1), width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 7),
            child: Text(
              category,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 5),
          Expanded(  // Gunakan Expanded untuk memastikan teks menutupi area sisa
            child: Text(
              label,
              style: TextStyle(fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,  // Agar teks tidak keluar dari batas
            ),
          ),
        ],
      ),
    );
  }
}
