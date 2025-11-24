import 'package:flutter/material.dart';

class DetailsTitleRow extends StatelessWidget {
  final String name;
  final String status;
  final Color statusColor;
  final double? reward;

  const DetailsTitleRow({
    required this.name,
    required this.status,
    required this.statusColor,
    required this.reward,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: statusColor.withOpacity(0.12),
          ),
          child: Row(
            children: [
              Icon(Icons.pets, size: 16, color: statusColor),
              const SizedBox(width: 4),
              Text(
                status,
                style: TextStyle(
                  fontSize: 12,
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        if (reward != null) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFFFFF3E0),
            ),
            child: Text(
              'Reward : ${reward!.toStringAsFixed(0)}\$',
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFFE67E22),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
