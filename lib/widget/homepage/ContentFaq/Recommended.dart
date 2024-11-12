import 'package:flutter/material.dart';
import 'package:travelease_mobile/widget/homepage/ContentFaq/CustomContainer.dart';

class Recommended extends StatefulWidget {
  const Recommended({ Key? key }) : super(key: key);

  @override
  State<Recommended> createState() => _RecommendedState();
}

class _RecommendedState extends State<Recommended> {
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
                    ),
                  CustomContainer(
                      label:
                          "Apakah harga yang tercantum sudah termasuk pajak dan biaya lainnya?",
                      ),
                  CustomContainer(
                      label:
                          "Apakah saya memerlukan visa untuk bepergian ke negara tertentu?",
                      ),
                  CustomContainer(
                      label:
                          "Bagaimana cara memesan tiket perjalanan melalui aplikasi?",
                      ),
                  CustomContainer(
                      label:
                          "Apakah aplikasi mendukung pemesanan untuk beberapa moda transportasi (pesawat, kereta, bus)?",
                      ),
                  CustomContainer(
                      label:
                          "Bagaimana cara memesan tiket perjalanan melalui aplikasi?",
                      ),
                  CustomContainer(
                      label:
                          "Apakah aplikasi mendukung pemesanan untuk beberapa moda transportasi (pesawat, kereta, bus)?",
                      ),
                ],
              ),
            );
  }
}

