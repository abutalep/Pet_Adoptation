import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.category,
    required this.selectedCategory,
    required this.onSelected,
  });

  final String category;
  final String selectedCategory;
  final Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedCategory == category;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Color(0xFF44174E) : Colors.white,
      ),
      onPressed: () => onSelected(category),
      child: Text(
        category,
        style: TextStyle(
          color: isSelected ? Colors.white : Color(0xFF44174E),
        ),
      ),
    );
  }
}
