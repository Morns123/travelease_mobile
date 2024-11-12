import 'package:flutter/material.dart';

class Category {
  final String name;
  final Color color;

  Category({required this.name, required this.color});
}

class ProblemCategory extends StatefulWidget {
  final List<Category> categories;
  final ValueChanged<String> onSelected;
  final int defaultSelectedIndex; // Tambahkan parameter defaultSelectedIndex

  const ProblemCategory({
    super.key,
    required this.categories,
    required this.onSelected,
    this.defaultSelectedIndex = 0, // Default category pertama terpilih
  });

  @override
  _ProblemCategoryState createState() => _ProblemCategoryState();
}

class _ProblemCategoryState extends State<ProblemCategory> {
  late int selectedButtonIndex;

  @override
  void initState() {
    super.initState();
    selectedButtonIndex = widget.defaultSelectedIndex;
    // Panggil callback dengan category default yang dipilih
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onSelected(widget.categories[selectedButtonIndex].name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.categories.asMap().entries.map((entry) {
        int index = entry.key;
        Category category = entry.value;
        return buildButton(index, category);
      }).toList(),
    );
  }

  Widget buildButton(int index, Category category) {
    bool isSelected = selectedButtonIndex == index;

    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedButtonIndex = index;
          });
          widget.onSelected(category.name); // Panggil callback saat tombol diklik
        },
        style: ButtonStyle(
          minimumSize: const MaterialStatePropertyAll(Size(90, 30)),
          backgroundColor: MaterialStatePropertyAll(
            isSelected ? Colors.white : category.color,
          ),
          side: isSelected
              ? MaterialStatePropertyAll(BorderSide(color: category.color, width: 2))
              : MaterialStatePropertyAll(BorderSide.none),
        ),
        child: Text(
          category.name,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isSelected ? category.color : Colors.white,
          ),
        ),
      ),
    );
  }
}
