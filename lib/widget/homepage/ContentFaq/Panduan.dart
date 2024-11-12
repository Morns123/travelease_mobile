import 'package:flutter/material.dart';
import 'package:travelease_mobile/widget/homepage/CategoryFAQ.dart';
import 'package:travelease_mobile/widget/homepage/ContentFaq/CustomContainer.dart';

class Panduan extends StatefulWidget {
  const Panduan({Key? key}) : super(key: key);

  @override
  State<Panduan> createState() => _PanduanState();
}

class _PanduanState extends State<Panduan> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          CustomContainer(
              label: "Bagaimana cara memesan tiket melalui aplikasi?",
              ),
              
          CustomContainer(
              label: "Cara membatalkan pemesanan tiket.",
              ),
          // Tambahkan pertanyaan lainnya sesuai kebutuhan
        ],
      ),
    );
  }
}
