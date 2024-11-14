import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:travelease_mobile/widget/homepage/ContentFaq/CustomContainer.dart';

class Umum extends StatefulWidget {
  final int categoryId; // Dapatkan categoryId dari pilihan pengguna

  Umum({required this.categoryId});

  @override
  State<Umum> createState() => _UmumState();
}

class _UmumState extends State<Umum> {
  List<String> faqs = [];
  bool isLoading = true;

  Future<void> fetchFaqsByCategory() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/faqs/category/${widget.categoryId}'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
       faqs = data.map((item) {
  return item.containsKey('question') ? item['question'].toString() : '';
}).where((question) => question.isNotEmpty).toList();

        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchFaqsByCategory();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
          height: 350,
          child: ListView(
             padding: EdgeInsets.zero,
              children: faqs.map((faq) => CustomContainer(label: faq)).toList(),
            ),
        );
  }
}
