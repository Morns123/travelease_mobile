import 'package:flutter/material.dart';

class Categoryfaq extends StatelessWidget {
  const Categoryfaq({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
            margin: EdgeInsets.only(left: 10),
            height: 32,
         
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                CustomContainer(label: 'Recommended', isOutlined: true),
                SizedBox(width: 10),
                CustomContainer(label: 'Penawaran & Promo'),
                SizedBox(width: 10),
                CustomContainer(label: 'Refund'),
                SizedBox(width: 10),
                CustomContainer(label: 'Supir Bermasalah'),
              ],
            ),
          );
  }
}

class CustomContainer extends StatelessWidget {
  final String label;
  final bool isOutlined;

  CustomContainer({required this.label, this.isOutlined = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('$label clicked');
        
      },
      child: Container(
        decoration: BoxDecoration(
          color: isOutlined ? Colors.transparent : Color.fromRGBO(103, 153, 195, 1),
          border: isOutlined ? Border.all(color: Color.fromRGBO(54, 99, 137, 1)) : null,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            child: Text(
              label,
              style: TextStyle(color: isOutlined ? Color.fromRGBO(54, 99, 137, 1) : Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}