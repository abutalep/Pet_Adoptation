import 'package:flutter/material.dart';

class DetailsAttributesSection extends StatelessWidget {
  final String category;
  final String color;
  final String age;

  const DetailsAttributesSection({
    super.key,
    required this.category,
    required this.color,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    final labelStyle = const TextStyle(
      fontSize: 13,
      color: Colors.black54,
      fontWeight: FontWeight.w600,
    );
    final valueStyle = const TextStyle(fontSize: 13, color: Colors.black87);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _item('Category', category, labelStyle, valueStyle),
        _item('Color', color, labelStyle, valueStyle),
        _item('Age', age, labelStyle, valueStyle),
      ],
    );
  }

  Widget _item(
    String label,
    String value,
    TextStyle labelStyle,
    TextStyle valueStyle,
  ) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: labelStyle),
          const SizedBox(height: 4),
          Text(value, style: valueStyle),
        ],
      ),
    );
  }
}
