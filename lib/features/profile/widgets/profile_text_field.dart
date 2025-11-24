import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final String label;
  final String initialValue;
  final bool enabled;

  const ProfileTextField({
    super.key,
    required this.label,
    required this.initialValue,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFFB4A4B8)),
        filled: true,
        fillColor: const Color(0xFFF5F2F7),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0D2EA), width: 1.2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0D2EA), width: 1.2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0D2EA), width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4B1A45), width: 1.4),
        ),
      ),
      style: const TextStyle(fontSize: 14),
    );
  }
}
