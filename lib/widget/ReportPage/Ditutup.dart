import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:travelease_mobile/Page/DetailReport.dart';

class DitutupWidget extends StatefulWidget {
  final String token;

  const DitutupWidget({super.key, required this.token});

  @override
  State<DitutupWidget> createState() => _DitutupWidgetState();
}

class _DitutupWidgetState extends State<DitutupWidget> {
  List<dynamic> tickets = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTickets();
  }

  Future<void> _fetchTickets() async {
    final response = await http.get(
      Uri.parse('http://192.168.39.147:8000/api/ticket?status=closed'), // Filter berdasarkan status 'closed'
      headers: {
        'Authorization': 'Bearer ${widget.token}', // Menggunakan token
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        tickets = json.decode(response.body)['data'];
        isLoading = false;
      });
    } else {
      // Handle error
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load tickets');
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailReport(tiket: tickets[index],)));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 12),
                        decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(8)
                        ),
                        width: 380,
                        height: 100,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 8),
                                  child: Text(tickets[index]['title'], style: TextStyle(color: Colors.black, fontSize: 15,fontFamily: "Montserrat-Bold"),)
                                  ),
                              ],
                            ),
                                  Row(
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                        maxWidth: 320,
                                        ),
                                        margin: EdgeInsets.only(left: 20,top: 5),
                                        child: Text(tickets[index]['description'], style: TextStyle(fontSize: 13), maxLines: 2,)
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: 15,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        child: Text("Kode Laporan : ${tickets[index]['ticket_no']}",style: TextStyle(fontSize: 11),),
                                      ),
                            
                                      Container(
                                        child: Text(tickets[index]['created_at'],style: TextStyle(fontSize: 11),),
                                      )
                                    ],
                                  )
                          ],
                        ),
                      ),
                    )
                  ],
                              ),
                ],
              );
            },
          );
  }
}
