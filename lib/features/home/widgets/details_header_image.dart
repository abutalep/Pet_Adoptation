import 'package:flutter/material.dart';

class DetailsHeaderImage extends StatefulWidget {
  final String imageUrl;
  const DetailsHeaderImage({super.key, required this.imageUrl});

  @override
  State<DetailsHeaderImage> createState() => _DetailsHeaderImageState();
}

class _DetailsHeaderImageState extends State<DetailsHeaderImage> {
  int current = 0;

  @override
  Widget build(BuildContext context) {
    final images = [widget.imageUrl, widget.imageUrl, widget.imageUrl];

    return Column(
      children: [
        SizedBox(
          height: 260,
          width: double.infinity,
          child: PageView.builder(
            itemCount: images.length,
            onPageChanged: (i) => setState(() => current = i),
            itemBuilder: (_, index) {
              return ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: Image.network(images[index], fit: BoxFit.cover),
              );
            },
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            images.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: i == current ? 16 : 7,
              height: 7,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: i == current
                    ? const Color(0xFF4B1A45)
                    : Colors.grey[400],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
