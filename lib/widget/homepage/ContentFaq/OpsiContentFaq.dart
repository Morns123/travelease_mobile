import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OpsiContentFaq extends StatefulWidget {
  final Function(int) onCategorySelected;

  OpsiContentFaq({required this.onCategorySelected});

  @override
  State<OpsiContentFaq> createState() => _OpsiContentFaqState();
}

class _OpsiContentFaqState extends State<OpsiContentFaq> {
  int selectedIndex = 0;

  // Daftar kategori yang akan diambil dari API
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  // Fungsi untuk mengambil data kategori dari API
  Future<void> fetchCategories() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/categories'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      setState(() {
        categories = data.map((categoryJson) => Category.fromJson(categoryJson)).toList();
      });
    } else {
      // Tangani error jika API gagal
      print('Failed to load categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return categories.isEmpty
        ? Center(child: CircularProgressIndicator()) // Tampilkan loading jika kategori belum tersedia
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((category) {
                int index = categories.indexOf(category);
                bool isSelected = selectedIndex == index;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: _buildCategory(isSelected, category),
                );
              }).toList(),
            ),
          );
  }

  Widget _buildCategory(bool isSelected, Category category) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = categories.indexOf(category);
          widget.onCategorySelected(selectedIndex);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? Colors.transparent : category.color,
          border: isSelected
              ? Border.all(color: category.color, width: 2)
              : Border.all(color: Color.fromRGBO(54, 99, 137, 1)),
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

  Category({required this.name, required this.color});

  // Factory constructor untuk parsing JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name_category'], // Sesuaikan dengan nama field di API Anda
      color: _getCategoryColor(json['name_category']), // Mengambil warna berdasarkan nama kategori
    );
  }

  // Fungsi untuk menentukan warna berdasarkan nama kategori
  static Color _getCategoryColor(String categoryName) {
    switch (categoryName) {
      case 'Recommended':
        return Colors.blue;
      case 'Penawaran & Promo':
        return Colors.green;
      case 'Panduan':
        return Colors.orange;
      case 'Umum':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
