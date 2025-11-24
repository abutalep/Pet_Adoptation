import 'package:flutter/material.dart';

class AlreadyHomeDialog extends StatelessWidget {
  const AlreadyHomeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      title: const Text("Already Home"),
      content: const Text("Thanks to you, this animal is already home."),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Ok"),
        ),
      ],
    );
  }
}
