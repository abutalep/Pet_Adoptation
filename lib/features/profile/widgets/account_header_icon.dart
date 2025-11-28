import 'package:flutter/material.dart';

class AccountHeaderIcon extends StatelessWidget {
  const AccountHeaderIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: 90,
        backgroundColor: const Color(0xFFF6ECF3),
        child: Container(
          width: 160,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 5, color: const Color(0xFF4B1A45)),
          ),
          child: const Icon(
            Icons.person_outline,
            size: 100,
            color: Color(0xFF4B1A45),
          ),
        ),
      ),
    );
  }
}
