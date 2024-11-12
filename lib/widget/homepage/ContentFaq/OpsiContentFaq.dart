import 'package:flutter/material.dart';

class OpsiContentFaq extends StatefulWidget {
  final Function(int) onCategorySelected;

  OpsiContentFaq({required this.onCategorySelected});

  @override
  State<OpsiContentFaq> createState() => _OpsiContentFaqState();
}

class _OpsiContentFaqState extends State<OpsiContentFaq> {
  int selectedIndex = 0;

  // Definisikan daftar kategori dengan nama dan warna masing-masing
  final List<Category> categories = [
    Category(name: "Recommended", color: Colors.blue),
    Category(name: "Penawaran & Promo", color: Colors.green),
    Category(name: "Panduan", color: Colors.orange),
    Category(name: "Umum", color: Colors.purple),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          color: category.name == "Recommended" && !isSelected
              ? Colors.blue
              : (isSelected ? Colors.transparent : category.color),
          border: isSelected
              ? Border.all(color: category.color, width: 2)
              : Border.all(color: Color.fromRGBO(54, 99, 137, 1)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          category.name,
          style: TextStyle(
            color: isSelected
                ? category.color
                : category.name == "Recommended"
                    ? Colors.white
                    : Colors.white,
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
}
