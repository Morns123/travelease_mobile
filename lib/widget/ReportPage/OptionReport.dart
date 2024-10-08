import 'package:flutter/material.dart';

class OpsiReport extends StatefulWidget {
  final Function(int) onCategorySelected;

  OpsiReport({required this.onCategorySelected});

  @override
  State<OpsiReport> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<OpsiReport> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 60,
                        width: 400,
                        child:
                            ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                _buildcategory("Sedang Berlangsung", 0),
                                _buildcategory("Ditutup", 1),
                              ],
                            ),
                        
                      ),
                    ],
                  ),
    );
  }
  Widget _buildcategory(String category, int index) {
  return InkWell(
    onTap: () {
      setState(() {
        selectedIndex = index;
        widget.onCategorySelected(index);
      });
    },
    child: Container(
                      width: 200,
                      margin: EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(
                          width: 2,
                          color: selectedIndex == index ? Color.fromRGBO(54, 99, 137, 1) : Colors.white,
                          // color: Color.fromRGBO(54, 99, 137, 1)
                          )),
                      ),
                      
                      child: Center(
                        child: Text(category, style: TextStyle(color: Color.fromRGBO(54, 99, 137, 1),fontSize: 15,fontFamily: "Montserrat-Bold"),),
                      ),
                    ),
  );
}
}