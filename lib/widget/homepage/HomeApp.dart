import 'package:flutter/material.dart';
import 'package:travelease_mobile/Page/pages/help_center_page/help_center.dart';
import 'package:travelease_mobile/Page/pages/profile_page/profile.dart';

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color.fromRGBO(103, 153, 195, 1), Color.fromRGBO(194, 223, 248, 1)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight
        )
      ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color.fromRGBO(103, 153, 195, 1), Color.fromRGBO(194, 223, 248, 1)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight
        )
      ),
                  height: 165,       
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                       
                        children: [
                        
                             Container(
                              margin: EdgeInsets.only(top: 24,),
                              child: ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: [Color.fromRGBO(228, 243, 255, 1), Colors.white],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  ).createShader(bounds),
                                child: Text("TravelEase",style: TextStyle(color: Colors.white,fontSize: 23, fontFamily: "Montserrat-ExtraBold"),))
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
                                  color: const Color.fromARGB(255, 147, 187, 221),
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
                              margin: EdgeInsets.only(top: 20),
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