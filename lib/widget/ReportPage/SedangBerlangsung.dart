import 'package:flutter/material.dart';

class Sdg_BerlangsungWiget extends StatelessWidget {
  const Sdg_BerlangsungWiget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(8)
                ),
                width: 380,
                height: 100,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 8),
                          child: Text("Pembatalan Pesanan", style: TextStyle(color: Colors.black, fontSize: 15,fontFamily: "Montserrat-Bold"),)
                          ),
                      ],
                    ),
                          Row(
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                maxWidth: 320,
                                ),
                                margin: EdgeInsets.only(left: 20,top: 5),
                                child: Text("Saya: Apakah saya bisa membatalkan pesanan yang", style: TextStyle(fontSize: 13), maxLines: 2,)
                                ),
                            ],
                          ),
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: Text("Kode Laporan : A55032",style: TextStyle(fontSize: 11),),
                              ),

                              Container(
                                child: Text("03 September 2024 15.28",style: TextStyle(fontSize: 11),),
                              )
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