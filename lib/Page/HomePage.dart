import 'package:flutter/material.dart';
import 'package:travelease_mobile/Page/ReportPage.dart';
import 'package:travelease_mobile/Page/chat_bot.dart';
import 'package:travelease_mobile/Page/pages/help_center_page/help_center.dart';
import 'package:travelease_mobile/widget/homepage/CategoryFAQ.dart';
import 'package:travelease_mobile/widget/homepage/Categorybase.dart';
import 'package:travelease_mobile/widget/homepage/FAQ.dart';
import 'package:travelease_mobile/widget/homepage/HomeApp.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HomeApp(),
            SizedBox(
              height: 10,
            ),
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
                    )),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ReportPage(onCategorySelected: (int ) {  })));
                  },
                  child: Container(
                      child: Row(
                    children: [
                      Text(
                        "Riwayat Laporan",
                        style: TextStyle(
                            fontSize: 15,
                            color:  Colors.black38,
                            fontFamily: "Montserrat-Bold"),
                      ),
                      Icon(Icons.keyboard_arrow_right,color: Colors.black38)
                    ],
                  )),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            const Categorybase(),
            Container(
              margin: EdgeInsets.only(top: 15),
              color: Color.fromRGBO(217, 217, 217, 1),
              height: 10,
            ),
            SizedBox(
              height: 15,
            ),
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
                    )),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpCenterPage()));
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
                      Icon(Icons.keyboard_arrow_right,color: Colors.black38,)
                    ],
                  )),
                ),
              ],
            ),
           const SizedBox(
              height: 10,
            ),
            const Categoryfaq(),
            SizedBox(height: 10,),
            const FAQWidget(),
            Container(
              margin: EdgeInsets.only(top: 15),
              color: Color.fromRGBO(217, 217, 217, 1),
              height: 10,
            ),
          SizedBox(height: 13,),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text("Hubungi Kami", style: TextStyle(fontSize: 18,color: Color.fromRGBO(30, 71, 105, 1),fontFamily: "Montserrat-Bold"),))
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatBot()));
            }, 
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10,left: 15),
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                  color: Color.fromRGBO(103, 153, 195, 1),
                  borderRadius: BorderRadius.circular(50)
                  ),
                  child: Icon(Icons.chat_bubble_outline,color: Colors.white,)
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text('Chat Dengan TravleMate',style: TextStyle(color: Color.fromRGBO(103, 153, 195, 1), fontSize: 16, fontFamily: "Montserrat-Bold"),),
                ),
              ],
            ),
          ),
          SizedBox(height: 25,)
          ],
        ),
      ),
    );
  }
}

