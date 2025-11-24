import 'package:flutter/material.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/section_title.dart';
import '../../../../core/widgets/animal_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search")),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              AppTextField(
                label: "Search",
                hint: "Name, type, city ...",
                controller: _searchController,
                prefixIcon: const Icon(Icons.search),
              ),
              const SizedBox(height: 16),
              const SectionTitle(title: "Results"),
              const SizedBox(height: 8),
              Expanded(
                child: ListView(
                  children: [
                    AnimalCard(
                      name: "Luna",
                      imageUrl:
                          "https://images.pexels.com/photos/4587995/pexels-photo-4587995.jpeg",
                      location: "Cairo, Egypt",
                      time: "Added 2h ago",
                      status: "Lost",
                      onTap: () {
                        // TODO: go to details
                      },
                    ),
                    AnimalCard(
                      name: "Max",
                      imageUrl:
                          "https://images.pexels.com/photos/1805164/pexels-photo-1805164.jpeg",
                      location: "Giza, Egypt",
                      time: "Added 1 day ago",
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
