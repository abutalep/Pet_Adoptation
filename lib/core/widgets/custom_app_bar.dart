import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool center;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.center = true,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: center,
      elevation: 0,
      backgroundColor: Colors.white,
      actions: actions,
    );
  }
}
