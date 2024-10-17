import 'package:flutter/material.dart';
import 'package:travelease_mobile/Page/pages/detail_problem_page/detail_problem.dart';

class CustomContainer extends StatelessWidget {
  final String category;
  final String label;

  CustomContainer({required this.label, required this.category});

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
            Container(
              margin: EdgeInsets.only(left: 7),
              child: Text(
                category,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: 5),
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
