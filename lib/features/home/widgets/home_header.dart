import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final VoidCallback onProfileTap;
  const HomeHeader({super.key, required this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onProfileTap,
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xFFE4CBDD),
            child: const Icon(
              Icons.person_outline,
              size: 28,
              color: Color(0xFF4B1A45),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Welcome',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
              SizedBox(height: 2),
              Text(
                'User',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.chevron_right, color: Colors.black54),
        ],
      ),
    );
  }
}
