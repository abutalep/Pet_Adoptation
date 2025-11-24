import 'package:flutter/material.dart';

class AddPhotosBox extends StatelessWidget {
  final VoidCallback onTap;

  const AddPhotosBox({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFDAC4E4)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.image_outlined, size: 32, color: Color(0xFF4B1A45)),
            SizedBox(height: 6),
            Text('Add photos', style: TextStyle(fontSize: 11)),
            SizedBox(height: 2),
            Text(
              'you can add up to 10 photos',
              style: TextStyle(fontSize: 9, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
