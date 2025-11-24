import 'package:flutter/material.dart';
import 'category_card.dart';

class CategoriesRow extends StatefulWidget {
  const CategoriesRow({super.key});

  @override
  State<CategoriesRow> createState() => _CategoriesRowState();
}

class _CategoriesRowState extends State<CategoriesRow> {
  String selected = 'Cat';

  @override
  Widget build(BuildContext context) {
    final items = [
      CategoryItem(label: 'Cat', emoji: '🐱', bgColor: const Color(0xFFFFF2C9)),
      CategoryItem(label: 'Dog', emoji: '🐶', bgColor: const Color(0xFFEFE3FF)),
      CategoryItem(
        label: 'Bird',
        emoji: '🦜',
        bgColor: const Color(0xFFFFE7E1),
      ),
    ];

    return SizedBox(
      height: 105,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) {
          return CategoryCard(
            data: items[i],
            isSelected: items[i].label == selected,
            onTap: () => setState(() => selected = items[i].label),
          );
        },
      ),
    );
  }
}

class CategoryItem {
  final String label;
  final String emoji;
  final Color bgColor;
  const CategoryItem({
    required this.label,
    required this.emoji,
    required this.bgColor,
  });
}
