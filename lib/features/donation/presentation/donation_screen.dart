import 'package:flutter/material.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../../core/widgets/app_button.dart';

class DonationScreen extends StatelessWidget {
  const DonationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Donation")),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Support HopePaw",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              const Text(
                "Your donation helps pets get food, medical care, and a chance to find a new home.",
              ),
              const SizedBox(height: 24),
              AppButton(
                title: "Contact to donate",
                onPressed: () {
                  // TODO: open contact / mail / whatsapp
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
