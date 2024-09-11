import 'package:flutter/material.dart';

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
                  height: 145,       
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