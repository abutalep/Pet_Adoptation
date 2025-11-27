import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

import 'package:hopepaw/features/lang/UI/screens/language_screen.dart';
import 'package:hopepaw/features/navigation/UI/screens/navigationScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Fade Animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    // Scale Animation
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _animationController.forward();

    
    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const NavigationScreen()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LanguageScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const purpleColor = Color(0xFF7B61FF);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              purpleColor.withOpacity(0.1),
              purpleColor.withOpacity(0.05),
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo with animations
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: SvgPicture.asset(
                        'assets/Frame 98.svg',
                        width: 200,
                        height: 200,
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),

              // App Name with fade animation
              FadeTransition(
                opacity: _fadeAnimation,
                child: const Text(
                  'Hope Paw',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: purpleColor,
                    letterSpacing: 1.2,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Tagline
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'Helping lost pets find their way home',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              const SizedBox(height: 50),

              // Loading indicator
              FadeTransition(
                opacity: _fadeAnimation,
                child: const SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(purpleColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
