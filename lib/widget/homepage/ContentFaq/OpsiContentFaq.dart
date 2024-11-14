import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';



class OpsiContentFaq extends StatefulWidget {
  final Function(int) onCategorySelected;

  OpsiContentFaq({required this.onCategorySelected});

  @override
  State<OpsiContentFaq> createState() => _OpsiContentFaqState();
}

class _OpsiContentFaqState extends State<OpsiContentFaq> {
  int selectedIndex = 0;
  bool isLoading = true;
  List<dynamic> faqs = [];

  // Definisikan daftar kategori dengan nama dan warna masing-masing
  final List<Category> categories = [
    Category(name: "Recommended", color: Colors.blue, apiCategoryId: 4),
    Category(name: "Penawaran & Promo", color: Colors.green, apiCategoryId: 5),
    Category(name: "Panduan", color: Colors.orange, apiCategoryId: 6),
    Category(name: "Umum", color: Colors.purple, apiCategoryId: 7),
  ];

 @override
  void initState() {
    super.initState();
    fetchFaqsByCategory();
  }

Future<void> fetchFaqsByCategory() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/faqs/category/${categories}'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data is List) {
      setState(() {
        faqs = data
            .map((item) => item.containsKey('question') ? item['question'].toString() : '')
            .where((question) => question.isNotEmpty)
            .toList();
        isLoading = false;
      });
    } else {
      print("Expected a List but got something else.");
    }
  } else {
    print("Failed to fetch FAQs. Status code: ${response.statusCode}");
  }
}


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 40,
        width: 700,
        child: Column(
            children: [
                Row(
                  children: categories.map((category) {
                    int index = categories.indexOf(category);
                    bool isSelected = selectedIndex == index;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: _buildCategory(isSelected, category),
                    );
                  }).toList(),
                ),
             
              Expanded(
                child: ListView.builder(
                  itemCount: faqs.length,
                  itemBuilder: (context, index) {
                    final faq = faqs[index];
                    return ListTile(
                      title: Text('[${faq['type']}] ${faq['question']}'),
             
                    );
                  },
                ),
              ),
            ],
          ),
      ),
    );
  }

  Widget _buildCategory(bool isSelected, Category category) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = categories.indexOf(category);
          fetchFaqsByCategory();
          widget.onCategorySelected(selectedIndex);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : category.color,
          border: Border.all(
            color: isSelected ? category.color : Color.fromRGBO(54, 99, 137, 1),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          category.name,
          style: TextStyle(
            color: isSelected ? category.color : Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class Category {
  final String name;
  final Color color;
  final int apiCategoryId;

  Category({required this.name, required this.color, required this.apiCategoryId});
}
