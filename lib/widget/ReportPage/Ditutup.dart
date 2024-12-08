import 'package:flutter/material.dart';
import 'package:travelease_mobile/Page/DetailReport.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelease_mobile/widget/ReportPage/SedangBerlangsung.dart';

class DitutupWidget extends StatefulWidget {
  final String token;
  const DitutupWidget({super.key, required this.token});

  @override
  State<DitutupWidget> createState() => _DitutupWidgetState();
}

class _DitutupWidgetState extends State<DitutupWidget>
    with WidgetsBindingObserver {
  List<Ticket> tickets = [];
  bool isLoading = true;
  late String token;
  DateTime? lastFetchTime;
  final cacheDuration = const Duration(minutes: 5);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshTickets();
    }
  }

  Future<void> _initializeData() async {
    try {
      await _loadToken();
      await _loadCachedTickets();
      if (_shouldRefreshCache()) {
        await fetchTickets();
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error initializing data: $e');
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading data: $e')),
        );
      }
    }
  }

  Future<void> _loadToken() async {
    token = widget.token;
  }

  Future<void> _loadCachedTickets() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedData =
          prefs.getString('cached_closed_tickets'); // Different cache key
      final lastFetchTimeStr =
          prefs.getString('last_fetch_time_closed'); // Different time key

      if (cachedData != null && lastFetchTimeStr != null) {
        lastFetchTime = DateTime.parse(lastFetchTimeStr);
        final List<dynamic> ticketList = json.decode(cachedData);
        setState(() {
          tickets = ticketList
              .map((ticket) => Ticket.fromJson(ticket))
              .where(
                  (ticket) => ticket.status == "closed") // Only closed tickets
              .toList();
        });
      }
    } catch (e) {
      print('Error loading cached tickets: $e');
      rethrow;
    }
  }

  bool _shouldRefreshCache() {
    if (lastFetchTime == null) return true;
    final difference = DateTime.now().difference(lastFetchTime!);
    print('Cache age: ${difference.inMinutes} minutes');
    return difference > cacheDuration;
  }

  Future<void> fetchTickets() async {
    if (!mounted) return;

    if (token == null) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please login again')),
      );
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.10:8000/api/ticket'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('Connection timed out. Please try again.');
        },
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (!data['status']) {
          throw Exception(data['message'] ?? 'Failed to load tickets');
        }

        final List<Ticket> loadedTickets = (data['data'] as List)
            .map((ticket) => Ticket.fromJson(ticket))
            .where((ticket) => ticket.status == "closed") // Only closed tickets
            .toList();

        // Cache the response with different keys for closed tickets
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'cached_closed_tickets', json.encode(data['data']));
        await prefs.setString(
            'last_fetch_time_closed', DateTime.now().toIso8601String());

        if (!mounted) return;

        setState(() {
          tickets = loadedTickets;
          isLoading = false;
          lastFetchTime = DateTime.now();
        });
      } else {
        throw Exception('Server returned ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching tickets: $e');
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      if (tickets.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e is TimeoutException
                ? e.message
                : 'Error loading tickets. Please try again.'),
            duration: Duration(seconds: 3),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: _refreshTickets,
            ),
          ),
        );
      }
    }
  }

  Future<void> _refreshTickets() async {
    setState(() {
      isLoading = true;
    });
    await fetchTickets();
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
      body: RefreshIndicator(
        onRefresh: _refreshTickets,
        child: isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading tickets...'),
                  ],
                ),
              )
            : tickets.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Tidak ada tiket yang ditutup'),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _refreshTickets,
                          child: Text('Refresh'),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: tickets.length,
                    itemBuilder: (context, index) {
                      final ticket = tickets[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailReport(
                                  ticket: ticket,
                                  onReturn: () {
                                    _refreshTickets();
                                  }, token: token,
                                ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                width: 350,
                                height: 100,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.only(left: 20, top: 8),
                                          child: Text(
                                            ticket.title,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontFamily: "Montserrat-Bold",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(
                                            maxWidth: 320,
                                          ),
                                          margin:
                                              EdgeInsets.only(left: 20, top: 5),
                                          child: Text(
                                            ticket.description,
                                            style: TextStyle(fontSize: 13),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Kode Laporan : ${ticket.ticketNo}",
                                            style: TextStyle(fontSize: 11),
                                          ),
                                          Text(
                                            formatDateTime(ticket.createdAt),
                                            style: TextStyle(fontSize: 11),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
