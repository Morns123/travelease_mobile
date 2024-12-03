import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:travelease_mobile/service/faq_service.dart';

class Category {
  final String name;
  final Color color;

  Category({required this.name, required this.color});
}

class CategoryFaq extends StatefulWidget {
  final ValueChanged<String> onSelected;
  final int defaultSelectedIndex;

  const CategoryFaq({
    super.key,
    required this.onSelected,
    this.defaultSelectedIndex = 0,
  });

  @override
  _ProblemCategoryState createState() => _ProblemCategoryState();
}

class _ProblemCategoryState extends State<CategoryFaq> {
  late Future<List<dynamic>> _categoriesFuture;
  late int selectedButtonIndex;

  // Peta warna untuk setiap kategori
  final Map<String, Color> categoryColors = {
    'Penawaran & Promo': Colors.green,
    'Panduan': Colors.orange,
    'Umum': Colors.purple,
  };

  @override
  void initState() {
    super.initState();
    selectedButtonIndex = widget.defaultSelectedIndex;
    _categoriesFuture = getFaqCategoriesWithSubcategoriesAndFaqs(); // Memanggil API
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          List<dynamic> categories = snapshot.data!;

          // Filter kategori sesuai kebutuhan
          categories = categories.where((category) {
            return categoryColors.containsKey(category['name']);
          }).toList();

          return Row(
            children: categories.asMap().entries.map((entry) {
              int index = entry.key;
              var category = entry.value;
              return buildButton(index, category['name']); // Ambil nama kategori dari API
            }).toList(),
          );
        } else {
          return const Center(child: Text('Tidak ada kategori ditemukan.'));
        }
      },
    );
  }

  Widget buildButton(int index, String categoryName) {
    bool isSelected = selectedButtonIndex == index;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(right: 0,left: 6),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                selectedButtonIndex = index;
              });
              widget.onSelected(categoryName); // Callback untuk kategori terpilih
            },
            style: ButtonStyle(
              minimumSize: const MaterialStatePropertyAll(Size(90, 30)),
              backgroundColor: MaterialStatePropertyAll(
                isSelected ? Colors.white : categoryColors[categoryName], // Warna berdasarkan kategori
              ),
              side: isSelected
                  ? MaterialStatePropertyAll(
                      BorderSide(color: categoryColors[categoryName]!, width: 2),
                    )
                  : MaterialStatePropertyAll(BorderSide.none),
            ),
            child: Text(
              categoryName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isSelected ? categoryColors[categoryName] : Colors.white, // Warna teks
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class CustomContainer extends StatelessWidget {
  final String label;
  final bool isOutlined;

  CustomContainer({required this.label, this.isOutlined = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('$label clicked');
        
      },
      child: Container(
        decoration: BoxDecoration(
          color: isOutlined ? Colors.transparent : Color.fromRGBO(103, 153, 195, 1),
          border: isOutlined ? Border.all(color: Color.fromRGBO(54, 99, 137, 1)) : null,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            child: Text(
              label,
              style: TextStyle(color: isOutlined ? Color.fromRGBO(54, 99, 137, 1) : Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}