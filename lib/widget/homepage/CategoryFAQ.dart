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

  // Warna tetap berdasarkan urutan kategori
  final List<Color> fixedColors = [
    Colors.green,    // Warna pertama: Merah
    Colors.orange, // Warna kedua: Oranye
    Colors.purple, // Warna ketiga: Ungu
  ];

  @override
  void initState() {
    super.initState();
    selectedButtonIndex = widget.defaultSelectedIndex;
    _categoriesFuture = getFaqCategoriesWithSubcategoriesAndFaqs(); // Memanggil API
  }

  // Fungsi untuk mendapatkan warna berdasarkan urutan
  Color _getFixedColor(int index) {
    return fixedColors[index % fixedColors.length];
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

          return Row(
            children: categories.asMap().entries.map((entry) {
              int index = entry.key;
              var category = entry.value;
              return buildButton(index, category['name'], _getFixedColor(index));
            }).toList(),
          );
        } else {
          return const Center(child: Text('Tidak ada kategori ditemukan.'));
        }
      },
    );
  }

  Widget buildButton(int index, String categoryName, Color categoryColor) {
    bool isSelected = selectedButtonIndex == index;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(right: 0, left: 6),
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
              isSelected ? Colors.white : categoryColor, // Warna berdasarkan kategori
            ),
            side: isSelected
                ? MaterialStatePropertyAll(
                    BorderSide(color: categoryColor, width: 2),
                  )
                : MaterialStatePropertyAll(BorderSide.none),
          ),
          child: Text(
            categoryName,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: isSelected ? categoryColor : Colors.white, // Warna teks
            ),
          ),
        ),
      ),
    );
  }
}
