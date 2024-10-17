import 'package:flutter/material.dart';

class ProblemCategory extends StatefulWidget {
  final List<String> buttonLabels;
  final ValueChanged<String> onSelected;

  const ProblemCategory(
      {super.key, required this.buttonLabels, required this.onSelected});

  @override
  _ProblemCategoryState createState() => _ProblemCategoryState();
}

class _ProblemCategoryState extends State<ProblemCategory> {
  int selectedButtonIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.buttonLabels.asMap().entries.map((entry) {
        int index = entry.key;
        String label = entry.value;
        return buildButton(index, label);
      }).toList(),
    );
  }

  Widget buildButton(int index, String text) {
    bool isSelected = selectedButtonIndex == index;

    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedButtonIndex = index;
          });
          widget.onSelected(text); // Panggil callback di sini
        },
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(90, 30)),
          backgroundColor: WidgetStatePropertyAll(
            isSelected ? Colors.white : const Color(0xff6799C3),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isSelected ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
