import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  final String selectedCategory;
  final String selectedStatus;
  final List<String> categories;
  final Function(String) onCategoryChanged;
  final Function(String) onStatusChanged;

  const FilterBar({
    super.key,
    required this.selectedCategory,
    required this.selectedStatus,
    required this.categories,
    required this.onCategoryChanged,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final statuses = ['All', 'Lost', 'Found'];

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedCategory,
                items: categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (v) {
                  if (v != null) onCategoryChanged(v);
                },
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ToggleButtons(
          children: statuses.map((s) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(s),
          )).toList(),
          isSelected: statuses.map((s) => s == selectedStatus).toList(),
          onPressed: (index) => onStatusChanged(statuses[index]),
          borderRadius: BorderRadius.circular(10),
          selectedColor: Colors.white,
          color: const Color(0xFF44174E),
          fillColor: const Color(0xFF44174E),
        ),
      ],
    );
  }
}
