import 'package:flutter/material.dart';
import 'package:travelease_mobile/Page/pages/detail_problem_page/detail_problem.dart';

class CustomContainer extends StatelessWidget {
  final String label;

  CustomContainer({required this.label,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailProblemPage()));
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Color.fromRGBO(217, 217, 217, 1),
              width: 0.5,
            ),
            bottom: BorderSide(color: Color.fromRGBO(217, 217, 217, 1), width: 0.5),
          ),
        ),
        child: Row(
          children: [
           
            SizedBox(width: 20),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 12),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
