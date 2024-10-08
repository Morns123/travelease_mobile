import 'package:flutter/material.dart';
import 'package:travelease_mobile/widget/ReportPage/Ditutup.dart';
import 'package:travelease_mobile/widget/ReportPage/OptionReport.dart';
import 'package:travelease_mobile/widget/ReportPage/SedangBerlangsung.dart';

class ReportPage extends StatefulWidget {
  final Function(int) onCategorySelected;

  ReportPage({required this.onCategorySelected});
 

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  
  Widget displaywidget = Sdg_BerlangsungWiget();
  bool isLoading = false;
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: Column(
      
        children: [
          
          Container(
            height: 130,
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
                      child: Text("Riwayat Laporan",style: TextStyle(color: Color.fromRGBO(54, 99, 137, 1),fontSize: 22,fontFamily: "Montserrat-ExtraBold"),),
                    )
                  ],
                ),
                SizedBox(height: 8,),
                OpsiReport(onCategorySelected: (index) {
          _handleCategorySelection(index);
        },)
              ],
            ),
          ),
        SizedBox(height: 30,),
        Expanded(child: displaywidget),
        ],
      ),
    );
    
  } 
   void _handleCategorySelection(int index) {
    setState(() {
      isLoading = true;
    });

    // Atur Lamanya waktu loading
    Future.delayed(Duration(seconds: 0), () {
      setState(() {
        switch (index) {
          case 0:
            displaywidget = Sdg_BerlangsungWiget();
            break;
          case 1:
            displaywidget = DitutupWidget();
            break;
        
          // tambahin case untuk pilihan notif yang lain, index nya juga inget!!
        }
        selectedIndex = index;
        isLoading = false;
      });
    });
  }
    Widget _buildAnimatedWidget(Widget widget) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 0),
      child: isLoading ? Container() : widget,
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
    );
  }
}