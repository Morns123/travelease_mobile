import 'package:flutter/material.dart';
import 'package:travelease_mobile/Page/pages/help_center_page/help_center.dart';
import 'package:travelease_mobile/Page/pages/profile_page/profile.dart';

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
            color: Color.fromRGBO(103, 153, 195, 1),
            child: Row(
              children: [
                Container(
                  color: Color.fromRGBO(103, 153, 195, 1),
                  height: 165,       
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                       
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 24,left: 20),
                            child: Text("TravelEase",style: TextStyle(color: Colors.white,fontSize: 23, fontFamily: "Montserrat-ExtraBold"),)
                            ),
                            SizedBox(width: 180,),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 30),
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(50)
                                ),
                                child: Icon(Icons.person,color: Colors.white,),
                              ),
                            )
                        ],
                      ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20,top: 20),
                              width: 370,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Search",
                                  prefixIcon: Icon(Icons.search),
                                  border: InputBorder.none,
                                  filled: false,
                                ),
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                )
              ],
            ),
          );
  }
}