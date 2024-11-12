import 'package:flutter/material.dart';
import 'package:travelease_mobile/widget/homepage/ContentFaq/CustomContainer.dart';

class Penawaran extends StatefulWidget {
  const Penawaran({ Key? key }) : super(key: key);

  @override
  State<Penawaran> createState() => _PenawaranState();
}

class _PenawaranState extends State<Penawaran> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          CustomContainer(
              label: "Bagaimana cara menggunakan kode voucher",
              ),
          CustomContainer(
              label: "Promo 1: Diskon 50% untuk semua penerbangan.",
              ),
          CustomContainer(
              label: "Promo 2: Beli 1 tiket kereta, dapatkan 1 tiket bus gratis.",
              ),
          CustomContainer(
              label: "Penawaran spesial untuk liburan akhir tahun.",
              ),
        ],
      ),
    );
  }
}



