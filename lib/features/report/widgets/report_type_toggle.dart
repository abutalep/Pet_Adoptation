import 'package:flutter/material.dart';

class ReportTypeToggle extends StatelessWidget {
  final String selected; // 'Lost' or 'Found'
  final ValueChanged<String> onChanged;

  const ReportTypeToggle({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF4B1A45);
    const grey = Color(0xFFEADBEF);

    return Row(
      children: [
        Expanded(
          child: _buildButton(
            label: 'Lost',
            isSelected: selected == 'Lost',
            selectedColor: purple,
            unselectedColor: Colors.white,
            borderColor: purple,
            onTap: () => onChanged('Lost'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildButton(
            label: 'Found',
            isSelected: selected == 'Found',
            selectedColor: grey,
            unselectedColor: Colors.white,
            borderColor: grey,
            onTap: () => onChanged('Found'),
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required String label,
    required bool isSelected,
    required Color selectedColor,
    required Color unselectedColor,
    required Color borderColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : unselectedColor,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: borderColor),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}
