import 'package:flutter/material.dart';
import 'package:travelease_mobile/Page/chat_detail.dart';
import 'package:travelease_mobile/widget/ReportPage/SedangBerlangsung.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LaporanWidget extends StatefulWidget {
  final Ticket ticket;
  final String token;

  const LaporanWidget({Key? key, required this.ticket, required this.token}) : super(key: key);

  @override
  State<LaporanWidget> createState() => _LaporanWidgetState();
}

class _LaporanWidgetState extends State<LaporanWidget> {
  List<Map<String, dynamic>> laporanData = [];
  bool isLoading = true;
  late String token;

  @override
  void initState() {
    super.initState();
    _loadToken();
    _generateLaporanData();
  }

  Future<void> _loadToken() async {
      token = widget.token;
  }

  void _generateLaporanData() {
    final status = widget.ticket.status;
    final createdAt = widget.ticket.createdAt;

    // Base status for all tickets
    laporanData = [
      {
        'status': 'Laporan Diterima',
        'description':
            'Laporan kamu telah diterima dan akan kami respon sesegera mungkin.',
        'date': formatDateTime(createdAt),
        'isActive': true,
      },
    ];

    // Add status based on current ticket status
    if (status == "accepted") {
      laporanData.insert(0, {
        'status': 'Laporan Sedang Ditangani',
        'description':
            'Laporanmu sedang dalam proses penanganan oleh Customer Service',
        'date': formatDateTime(createdAt),
        'isActive': true,
      });
    } else if (status == "closed") {
      laporanData.insert(0, {
        'status': 'Laporan Ditutup',
        'description': 'Laporan Telah Selesai',
        'date': formatDateTime(createdAt),
        'isActive': true,
      });
      laporanData.insert(1, {
        'status': 'Laporan Selesai Ditangani',
        'description': 'Laporanmu ditandai "Selesai" oleh Customer Service',
        'date': formatDateTime(createdAt),
        'isActive': true,
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  String formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return "${dateTime.day} ${_getMonthName(dateTime.month)} ${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  String _getMonthName(int month) {
    const monthNames = [
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember"
    ];
    return monthNames[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
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
                        if (widget.ticket.status != "pending") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChatDetailPage(ticket: widget.ticket, token: token,),
                            ),
                          );
                        }
                      },
                      child: Text(
                        _getChatButtonText(widget.ticket.status),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: widget.ticket.status == "pending"
                              ? Colors.grey
                              : const Color.fromARGB(255, 201, 68, 58),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  String _getChatButtonText(String status) {
    switch (status) {
      case "pending":
        return "Menunggu";
      case "accepted":
        return "Mulai Percakapan";
      case "closed":
        return "Riwayat Chat";
      default:
        return "Menunggu";
    }
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
              margin: EdgeInsets.only(right: 0,bottom: 8,top: 5),
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
                height: 70,
                color: Colors.grey,
              ),
          ],
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
              left: 10,
            ),
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
