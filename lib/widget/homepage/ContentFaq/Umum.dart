import 'package:flutter/material.dart';
import 'package:travelease_mobile/widget/homepage/ContentFaq/CustomContainer.dart';

class Umum extends StatefulWidget {
  const Umum({Key? key}) : super(key: key);

  @override
  State<Umum> createState() => _UmumState();
}

class _UmumState extends State<Umum> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          CustomContainer(
              label: "Apa saja metode pembayaran yang diterima?",
              category: "[Umum]"),
          CustomContainer(
              label: "Bagaimana cara mengubah profil saya?",
              category: "[Umum]"),
          // Tambahkan pertanyaan lainnya sesuai kebutuhan
        ],
      ),
    );
  }
}


