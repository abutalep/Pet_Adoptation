import 'package:flutter/material.dart';

class ReportPhotoPicker extends StatelessWidget {
  final VoidCallback onTap;

  const ReportPhotoPicker({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 32),
        decoration: BoxDecoration(
          color: const Color(0xFFFDF7FF),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE0C8E8), width: 1.3),
        ),
        child: const Center(
          child: Text(
            'Select photos (max 4)',
            style: TextStyle(color: Color(0xFF9C7FAF), fontSize: 14),
          ),
        ),
      ),
    );
  }
}
