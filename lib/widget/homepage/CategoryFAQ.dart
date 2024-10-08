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
                CustomContainer(label: 'Penawaran & Promo',color: Colors.green,),
                SizedBox(width: 10),
                CustomContainer(label: 'Refund',color: const Color.fromARGB(255, 27, 99, 157),),
                SizedBox(width: 10),
                CustomContainer(label: 'Supir Bermasalah',color: Colors.red,),
              ],
            ),
          );
  }
}

class CustomContainer extends StatelessWidget {
  final String label;
  final bool isOutlined;
  final Color? color;

  CustomContainer({required this.label, this.isOutlined = false, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('$label clicked');
        
      },
      child: Container(
        decoration: BoxDecoration(
          color: isOutlined ? Colors.transparent : color,
          border: isOutlined ? Border.all(color: Color.fromRGBO(54, 99, 137, 1)) : null,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            child: Text(
              label,
              style: TextStyle(color: isOutlined ? Color.fromRGBO(54, 99, 137, 1) : Colors.white,fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}