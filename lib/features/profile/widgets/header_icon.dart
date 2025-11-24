import 'package:flutter/material.dart';

class HeaderIcon extends StatelessWidget {
  const HeaderIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: 34,
        backgroundColor: const Color(0xFFF6ECF3),
        child: Icon(Icons.pets, size: 32, color: const Color(0xFF4B1A45)),
      ),
    );
  }
}
