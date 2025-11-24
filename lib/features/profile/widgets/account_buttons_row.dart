import 'package:flutter/material.dart';

class AccountButtonsRow extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onEdit;

  const AccountButtonsRow({
    super.key,
    required this.onClose,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF4B1A45);

    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 46,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEBDDEB),
                foregroundColor: Colors.black54,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: onClose,
              child: const Text(
                'Close',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 46,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: onEdit,
              child: const Text(
                'Edit',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
