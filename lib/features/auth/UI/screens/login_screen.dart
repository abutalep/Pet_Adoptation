import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hopepaw/features/auth/Data/firebase/auth_service.dart';
import 'package:hopepaw/features/providers/language_provider.dart';
import 'package:hopepaw/features/auth/UI/screens/signup_screen.dart';
import 'package:provider/provider.dart';
import 'auth_login_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8), // Light beige background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // "login/signup" text at top left
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 4.0),
                child: Text(
                  'login/signup',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                    fontFamily: 'sans-serif',
                  ),
                ),
              ),

              const Spacer(),

              // White panel with rounded corners
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo icon at top left
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: SvgPicture.asset(
                        'assets/path7000.svg',
                        width: 40,
                        height: 40,
                      ),
                    ),

                    // Tagline with gradient text - Centered
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                            fontFamily: 'sans-serif',
                          ),
                          children: [
                            const TextSpan(
                              text: 'Because every paw deserves to find its way home — your all-in-one app for animal care, rescue, and adoption',
                              style: TextStyle(
                                color: Color(0xFF44174E), // Dark purple
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Pagination indicators
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // First dot (active - gradient oval)
                          Container(
                            width: 32,
                            height: 8,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF7B61FF),
                                  Color(0xFFD2691E),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Second dot
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Third dot
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Login button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AuthLoginScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF44174E), // Dark purple
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          lang.get('login'),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'sans-serif',
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Sign up button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF44174E), // Dark purple
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          lang.get('signup'),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'sans-serif',
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Sign in with Google button
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF7B61FF),
                            Color(0xFFD2691E),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(2),
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            final authService = AuthService();
                            await authService.signInWithGoogle();
                            // Navigation will be handled by auth state listener
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.toString().replaceAll('Exception: ', '')),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.grey[800],
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'sans-serif',
                            ),
                            children: [
                              TextSpan(
                                text: '${lang.get('sign_in_with_google').split(' ').take(3).join(' ')} ',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              TextSpan(
                                text: 'Google',
                                style: const TextStyle(
                                  color: Color(0xFFD2691E), // Orange-brown
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

