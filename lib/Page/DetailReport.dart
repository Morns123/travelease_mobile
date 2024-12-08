import 'package:flutter/material.dart';
import 'package:travelease_mobile/widget/DetailReport/LaporanCard.dart';
import 'package:travelease_mobile/widget/ReportPage/SedangBerlangsung.dart';

class DetailReport extends StatefulWidget {
  final Ticket ticket;
  final Function? onReturn;
  final String token;

  const DetailReport({
    Key? key, 
    required this.ticket,
    this.onReturn,
    required this.token
  }) : super(key: key);

  @override
  State<DetailReport> createState() => _DetailReportState();
}

class _DetailReportState extends State<DetailReport> {
  late String token;

  @override
  void initState() {
    super.initState();
        token = widget.token;

  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Call refresh function when going back
        if (widget.onReturn != null) {
          widget.onReturn!();
        }
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 0,),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(height: 40,),
                    Row(
                      children: [
                        SizedBox(width: 15,),
                        GestureDetector(
                          onTap: () {
                            if (widget.onReturn != null) {
                              widget.onReturn!();
                            }
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back,size: 30,)),
                        SizedBox(width: 25,),
                        Container(
                          child: Text("Detail Laporan",
                            style: TextStyle(
                              color: Color.fromRGBO(54, 99, 137, 1),
                              fontSize: 22,
                              fontFamily: "Montserrat-ExtraBold"
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(widget.ticket.title,
                            style: TextStyle(fontSize: 13,fontFamily: "Montserrat-Bold"),
                          )),
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Text(widget.ticket.status,
                            style: TextStyle(fontSize: 11),),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 5),
                          child: Row(
                            children: [
                              Text("Kode Laporan: ${widget.ticket.ticketNo}",
                                style: TextStyle(color: const Color.fromARGB(255, 116, 115, 114), fontSize: 11),),
                              IconButton(onPressed: () {}, icon: Icon(Icons.content_copy,size: 15,)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 400,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 201, 68, 58),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: LaporanWidget(ticket: widget.ticket, token: token,),
              ) 
            ],
          ),
        ),
      ),
    );
  }
}