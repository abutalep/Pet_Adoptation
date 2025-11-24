import 'package:flutter/material.dart';

class ChoiceChipButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const ChoiceChipButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF4B1A45);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? purple : const Color(0xFFF6ECF3),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: isSelected ? purple : const Color(0xFFE0D2EA),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
