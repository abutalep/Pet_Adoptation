import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  final double height;

  const AppDivider({super.key, this.height = 20});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Divider(
        color: Colors.grey.shade300,
        thickness: 1,
      ),
    );
  }
}
