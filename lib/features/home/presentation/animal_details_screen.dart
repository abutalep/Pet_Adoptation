import 'package:animel_core/features/home/widgets/details_attributes_section.dart';
import 'package:animel_core/features/home/widgets/details_header_image.dart';
import 'package:animel_core/features/home/widgets/details_owner_section.dart';
import 'package:animel_core/features/home/widgets/details_title_row.dart';
import 'package:animel_core/features/home/widgets/google_static_map.dart';
import 'package:flutter/material.dart';

class AnimalDetailsScreen extends StatelessWidget {
  final String name;
  final String status;
  final String category;
  final String color;
  final String age;
  final String ownerName;
  final String ownerEmail;
  final String description;
  final String location;
  final String imageUrl;
  final double? reward;

  const AnimalDetailsScreen({
    super.key,
    required this.name,
    required this.status,
    required this.category,
    required this.color,
    required this.age,
    required this.ownerName,
    required this.ownerEmail,
    required this.description,
    required this.location,
    required this.imageUrl,
    this.reward,
  });

  Color get _statusColor {
    switch (status.toLowerCase()) {
      case 'lost':
        return const Color(0xFFE57373);
      case 'found':
        return const Color(0xFF4FC3F7);
      case 'adopt':
        return const Color(0xFF81C784);
      case 'already home':
        return const Color(0xFF8D6E63);
      default:
        return const Color(0xFF4B1A45);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF6ECF3),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF4B1A45),
        title: Center(child: Text('Animal details')),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailsHeaderImage(imageUrl: imageUrl),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DetailsTitleRow(
                            name: name,
                            status: status,
                            statusColor: _statusColor,
                            reward: reward,
                          ),
                          const SizedBox(height: 16),
                          DetailsAttributesSection(
                            category: category,
                            color: color,
                            age: age,
                          ),
                          const SizedBox(height: 16),
                          DetailsOwnerSection(
                            name: ownerName,
                            email: ownerEmail,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Description',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            description,
                            style: const TextStyle(fontSize: 14, height: 1.5),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Location',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: Color(0xFF8C3A7B),
                                size: 18,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  location,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          GoogleStaticMap(address: location),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
