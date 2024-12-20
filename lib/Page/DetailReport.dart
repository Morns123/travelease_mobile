import 'package:flutter/material.dart';
import 'package:travelease_mobile/widget/DetailReport/LaporanCard.dart';

class DetailReport extends StatelessWidget {
  const DetailReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 231, 231),
      body: Column(
        children: [
       
          Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: 30,),
                Row(
                  children: [
                    SizedBox(width: 15,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back,size: 30,)),
                    SizedBox(width: 25,),
                    Container(
                      child: Text("Detail Laporan",style: TextStyle(color: Color.fromRGBO(54, 99, 137, 1),fontSize: 22,fontFamily: "Montserrat-ExtraBold"),),
                    )
                  ],
                ),
                    SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text("Pembatalan Pesanan", style: TextStyle(fontSize: 13,fontFamily: "Montserrat-Bold"),
                      )),
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Text("Sedang Berlangsung", style: TextStyle(fontSize: 11,color: Color.fromRGBO(90, 235, 76, 1)),),
                      )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 5),
                      child: Row(
                        children: [
                          Text("Kode Laporan: A55032", style: TextStyle(color: const Color.fromARGB(255, 116, 115, 114), fontSize: 11),),
                          IconButton(onPressed: () {}, icon: Icon(Icons.content_copy,size: 15,)),
                        ],
                      ),
                    ),
                  ],
                ),


              ],
            ),
          ),
                   Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 400,
                    decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 201, 68, 58),
                    borderRadius: BorderRadius.circular(20),
                    ),
                     child:  LaporanWidget(),
                   ) 
        ],
      ),
    );
  }
}