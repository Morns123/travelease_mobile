import 'package:flutter/material.dart';
import 'package:travelease_mobile/Page/ReportPage.dart';
import 'package:travelease_mobile/Page/chat_bot.dart';
import 'package:travelease_mobile/Page/pages/help_center_page/help_center.dart';
import 'package:travelease_mobile/widget/homepage/CategoryFAQ.dart';
import 'package:travelease_mobile/widget/homepage/Categorybase.dart';
import 'package:travelease_mobile/widget/homepage/ContentFaq/OpsiContentFaq.dart';
import 'package:travelease_mobile/widget/homepage/ContentFaq/Penawaran.dart';
import 'package:travelease_mobile/widget/homepage/ContentFaq/Recommended.dart';
import 'package:travelease_mobile/widget/homepage/ContentFaq/Panduan.dart'; // Widget baru
import 'package:travelease_mobile/widget/homepage/ContentFaq/Umum.dart'; // Widget baru
import 'package:travelease_mobile/widget/homepage/FAQ.dart';
import 'package:travelease_mobile/widget/homepage/HomeApp.dart';
import 'package:travelease_mobile/widget/homepage/ContentFaq/Panduan.dart';
import 'package:travelease_mobile/widget/homepage/ContentFaq/Umum.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget displayWidget = Recommended();
  bool isLoading = false;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HomeApp(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "Laporan Teratas",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: "Montserrat-Bold"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReportPage(
                          onCategorySelected: (int) {},
                        ),
                      ),
                    );
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Text(
                          "Riwayat Laporan",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black38,
                              fontFamily: "Montserrat-Bold"),
                        ),
                        Icon(Icons.keyboard_arrow_right, color: Colors.black38)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            const Categorybase(),
            Container(
              margin: EdgeInsets.only(top: 15),
              color: Color.fromRGBO(217, 217, 217, 1),
              height: 10,
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text(
                    "FAQ",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: "Montserrat-Bold"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HelpCenterPage(),
                      ),
                    );
                  },
                  child: Container(
                    child: const Row(
                      children: [
                        Text(
                          "Lihat Semua",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black38,
                              fontFamily: "Montserrat-Bold"),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.black38,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            OpsiContentFaq(
              onCategorySelected: (opsi) {
                _handleCategorySelection(opsi);
              },
            ),
            SizedBox(height: 5),
            displayWidget,
            Container(
              margin: EdgeInsets.only(top: 15),
              color: Color.fromRGBO(217, 217, 217, 1),
              height: 10,
            ),
            SizedBox(height: 13),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "Hubungi Kami",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(30, 71, 105, 1),
                        fontFamily: "Montserrat-Bold"),
                  ),
                )
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatBot()),
                );
              },
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 15),
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(103, 153, 195, 1),
                        borderRadius: BorderRadius.circular(50)),
                    child: Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      'Chat Dengan TravleMate',
                      style: TextStyle(
                          color: Color.fromRGBO(103, 153, 195, 1),
                          fontSize: 16,
                          fontFamily: "Montserrat-Bold"),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  void _handleCategorySelection(int opsi) {
  setState(() {
    isLoading = true;
  });

  Future.delayed(Duration(milliseconds: 100), () {
    setState(() {
      switch (opsi) {
        case 0:
          displayWidget = Recommended();
          break;
        case 1:
          displayWidget = Penawaran();
          break;
        case 2:
          displayWidget = Panduan();
          break;
        case 3:
          displayWidget = Umum();
          break;
        default:
          displayWidget = Recommended();
      }
      selectedIndex = opsi;
      isLoading = false;
      print("Kategori dipilih: $opsi"); // Debugging
    });
  });
}


  // Widget untuk animasi loading jika diperlukan
  Widget _buildAnimatedWidget(Widget widget) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 100),
      child: isLoading ? CircularProgressIndicator() : widget,
      switchInCurve: Curves.easeInExpo,
      switchOutCurve: Curves.easeOut,
    );
  }
}
