import 'package:flutter/material.dart';
import 'package:travelease_mobile/Page/ReportPage.dart';
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
                          color: Color.fromRGBO(54, 99, 137, 1),
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
                            color: Color.fromRGBO(54, 99, 137, 0.73),
                            fontFamily: "Montserrat-Bold"),
                      ),
                      Icon(Icons.keyboard_arrow_right)
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
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      "FAQ",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(54, 99, 137, 1),
                          fontFamily: "Montserrat-Bold"),
                    )),
                InkWell(
                  onTap: () {},
                  child: Container(
                      child: Row(
                    children: [
                      Text(
                        "Lihat Semua",
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(54, 99, 137, 0.73),
                            fontFamily: "Montserrat-Bold"),
                      ),
                      Icon(Icons.keyboard_arrow_right)
                    ],
                  )),
                ),
              ],
            ),
            SizedBox(
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
                child: Text("Hubungi Kami", style: TextStyle(fontSize: 18,color: Color.fromRGBO(103, 153, 195, 1),fontFamily: "Montserrat-Bold"),))
            ],
          ),
          Row(
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
          SizedBox(height: 25,)
          ],
        ),
      ),
    );
  }
}

