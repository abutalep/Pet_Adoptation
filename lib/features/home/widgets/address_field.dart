import 'package:flutter/material.dart';

class AddressField extends StatelessWidget {
  const AddressField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.location_on_outlined,
          color: Color(0xFF4B1A45),
        ),
        hintText: 'Enter Address',
        hintStyle: const TextStyle(color: Color(0xFFB4A4B8)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFEDC9E1), width: 1.3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF4B1A45), width: 1.5),
        ),
      ),
    );
  }
}
