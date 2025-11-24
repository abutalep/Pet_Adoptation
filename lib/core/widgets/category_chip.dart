// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: selected
              ? Theme.of(context).primaryColor.withOpacity(0.15)
              : const Color(0xFFF4F2F6),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: selected ? Theme.of(context).primaryColor : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
