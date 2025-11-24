import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PermissionsInfoScreen extends StatelessWidget {
  const PermissionsInfoScreen({super.key});

  void _continue(BuildContext context) {
    context.go("/welcome-auth");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              SizedBox(
                height: 130,
                width: 130,
                child: Image.asset(
                  'assets/image/image.png',
                  fit: BoxFit.contain,
                ),
              ),

              const Text(
                "HopePaw",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF4B1A45),
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Community Welcomes you",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF4B1A45),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "For the best experience, please follow these steps.",
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Location Settings",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "When a pet is lost, we need to connect with people nearby. "
                        "Please set your location in your device settings to allow all the time for HopePaw.",
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Enable Notifications",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "We notify people when a pet goes missing or when a search is in progress. "
                        "Please allow notifications to stay informed and help others.",
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4B1A45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => _continue(context),
                  child: const Text(
                    "Continue",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
