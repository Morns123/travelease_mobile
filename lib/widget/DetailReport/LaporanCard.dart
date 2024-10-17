import 'package:flutter/material.dart';
import 'package:travelease_mobile/Page/chat_detail.dart';

class LaporanWidget extends StatelessWidget {
  final List<Map<String, dynamic>> laporanData = [
    {
      'status': 'Laporan Ditutup',
      'description': 'Laporan Telah Selesai',
      'date': 'null',
      'isActive': false,
    },
    {
      'status': 'Laporan Selesai Ditangani',
      'description': 'Laporanmu ditandai “Selesai” oleh Customer Service',
      'date': '05 September 2024 10:21',
      'isActive': true,
    },
    {
      'status': 'Laporan Diterima',
      'description': 'Laporan kamu telat diterima dan akan kami respon sesegera mungkin.',
      'date': '05 September 2024 10:21',
      'isActive': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...laporanData.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> laporan = entry.value;
                bool isLast = index == laporanData.length - 1;
        
                return LaporanCard(
                  title: laporan['status'],
                  description: laporan['description'],
                  date: laporan['date'],
                  isActive: laporan['isActive'],
                  showLine: !isLast, 
                );
              }).toList(),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailPage()));
                },
                child: Text(
                  '#Riwayat Chat',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: const Color.fromARGB(255, 201, 68, 58)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LaporanCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final bool isActive;
  final bool showLine;

  LaporanCard({
    required this.title,
    required this.description,
    required this.date,
    required this.isActive,
    required this.showLine,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 0),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isActive ? Color.fromRGBO(54, 99, 137, 1) : Colors.grey,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            if (showLine)
              Container(
                width: 2,
                height: 80, 
                color: Colors.grey,
              ),
          ],
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 10,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
