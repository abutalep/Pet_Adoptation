import 'package:flutter/material.dart';

class AvatarCircle extends StatelessWidget {
  final String imageUrl;
  final double size;
  final VoidCallback? onTap;

  const AvatarCircle({
    super.key,
    required this.imageUrl,
    this.size = 42,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final avatar = CircleAvatar(
      radius: size / 2,
      backgroundImage: NetworkImage(imageUrl),
    );

    if (onTap == null) return avatar;

    return GestureDetector(
      onTap: onTap,
      child: avatar,
    );
  }
}
