import 'package:flutter/material.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../../core/widgets/section_title.dart';
import '../../../../core/widgets/animal_card.dart';

class AdoptListScreen extends StatelessWidget {
  const AdoptListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Adopt a friend")),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SectionTitle(title: "Available for adoption"),
              const SizedBox(height: 12),
              Expanded(
                child: ListView(
                  children: [
                    AnimalCard(
                      name: "Milo",
                      imageUrl:
                          "https://images.pexels.com/photos/3299903/pexels-photo-3299903.jpeg",
                      location: "Cairo, Egypt",
                      time: "Added 3 days ago",
                      status: "Adopt",
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
