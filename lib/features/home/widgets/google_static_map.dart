import 'package:flutter/material.dart';

class GoogleStaticMap extends StatelessWidget {
  final String address;
  final double height;
  final double borderRadius;

  const GoogleStaticMap({
    super.key,
    required this.address,
    this.height = 190,
    this.borderRadius = 16,
  });

  String _buildStaticUrl() {
    const apiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
    final encoded = Uri.encodeFull(address);

    return 'https://maps.googleapis.com/maps/api/staticmap'
        '?center=$encoded'
        '&zoom=15'
        '&size=600x300'
        '&scale=2'
        '&markers=color:red%7C$encoded'
        '&key=$apiKey';
  }

  @override
  Widget build(BuildContext context) {
    final url = _buildStaticUrl();

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) {
            return Container(
              color: Colors.grey.shade300,
              alignment: Alignment.center,
              child: const Text(
                'Could not load map',
                style: TextStyle(color: Colors.black54),
              ),
            );
          },
        ),
      ),
    );
  }
}
