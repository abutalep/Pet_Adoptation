import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/bottom_nav_bar.dart';
import '../widgets/home_header.dart';
import '../widgets/address_field.dart';
import '../widgets/categories_row.dart';
import '../widgets/animals_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF6ECF3),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 0),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Container(
              color: Colors.white,
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                children: [
                  HomeHeader(onProfileTap: () => context.go('/profile')),
                  const SizedBox(height: 18),
                  const AddressField(),
                  const SizedBox(height: 24),
                  Text(
                    'Recently added',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const CategoriesRow(),
                  const SizedBox(height: 18),
                  const Divider(height: 1, thickness: 0.6),
                  const SizedBox(height: 16),
                  const AnimalsGrid(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
