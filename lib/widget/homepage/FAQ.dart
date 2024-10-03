import 'package:flutter/material.dart';

class FAQWidget extends StatelessWidget {
  const FAQWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
              height: 350,
              color: Colors.white,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  CustomContainer(
                      label:
                          "Apakah harga yang tercantum sudah termasuk pajak dan biaya lainnya?",
                      category: "[Transaksi]"),
                  CustomContainer(
                      label:
                          "Apakah harga yang tercantum sudah termasuk pajak dan biaya lainnya?",
                      category: "[Refund]"),
                  CustomContainer(
                      label:
                          "Apakah saya memerlukan visa untuk bepergian ke negara tertentu?",
                      category: "[Transaksi]"),
                  CustomContainer(
                      label:
                          "Bagaimana cara memesan tiket perjalanan melalui aplikasi?",
                      category: "[Tiket]"),
                  CustomContainer(
                      label:
                          "Apakah aplikasi mendukung pemesanan untuk beberapa moda transportasi (pesawat, kereta, bus)?",
                      category: "[Transportasi]"),
                  CustomContainer(
                      label:
                          "Bagaimana cara memesan tiket perjalanan melalui aplikasi?",
                      category: "[Tiket]"),
                  CustomContainer(
                      label:
                          "Apakah aplikasi mendukung pemesanan untuk beberapa moda transportasi (pesawat, kereta, bus)?",
                      category: "[Transportasi]"),
                ],
              ),
            );
  }
}


class CustomContainer extends StatelessWidget {
  final String category;
  final String label;

  CustomContainer({required this.label, required this.category});

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
