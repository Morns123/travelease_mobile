import 'package:flutter/material.dart';
import 'package:travelease_mobile/widget/ReportPage/Ditutup.dart';
import 'package:travelease_mobile/widget/ReportPage/OptionReport.dart';
import 'package:travelease_mobile/widget/ReportPage/SedangBerlangsung.dart';

class ReportPage extends StatefulWidget {
  final Function(int) onCategorySelected;
  final String token;

  ReportPage({required this.onCategorySelected, required this.token});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late String _token;
  late Widget displaywidget;
  bool isLoading = false;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _token = widget.token;
    // Inisialisasi displaywidget dengan widget pertama berdasarkan token
    displaywidget = Sdg_BerlangsungWiget(token: _token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 231, 231),
      body: Column(
        children: [
          Container(
            height: 130,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: 30),
                Row(
                  children: [
                    SizedBox(width: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back, size: 30),
                    ),
                    SizedBox(width: 25),
                    Container(
                      child: Text(
                        "Riwayat Laporan",
                        style: TextStyle(
                            color: Color.fromRGBO(54, 99, 137, 1),
                            fontSize: 22,
                            fontFamily: "Montserrat-ExtraBold"),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 8),
                OpsiReport(onCategorySelected: (index) {
                  _handleCategorySelection(index);
                }, token: _token)
              ],
            ),
          ),
          Expanded(child: _buildAnimatedWidget(displaywidget)), // Gunakan _buildAnimatedWidget
        ],
      ),
    );
  }

  void _handleCategorySelection(int index) {
    setState(() {
      isLoading = true;
    });

    Future.delayed(Duration(seconds: 0), () {
      setState(() {
        switch (index) {
          case 0:
            displaywidget = Sdg_BerlangsungWiget(token: _token);
            break;
          case 1:
            displaywidget = DitutupWidget(token: _token);
            break;
          // Tambah case lain jika ada
        }
        selectedIndex = index;
        isLoading = false;
      });
    });
  }

  Widget _buildAnimatedWidget(Widget widget) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: isLoading ? Center(child: CircularProgressIndicator()) : widget,
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
    );
  }
}
