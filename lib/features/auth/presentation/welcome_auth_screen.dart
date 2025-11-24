import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeAuthScreen extends StatelessWidget {
  const WelcomeAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const lightPurple = Color(0xFFF6ECF3);
    const purple = Color(0xFF4B1A45);
    const orange = Color(0xFFE27D60);

    final baseTextStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: 18,
      height: 1.4,
    );

    return Scaffold(
      backgroundColor: lightPurple,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 28,
                      child: Image.asset(
                        'assets/image/image.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 200),
                    Center(
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          style: baseTextStyle,
                          children: [
                            const TextSpan(text: 'Because '),
                            TextSpan(
                              text: 'Every Paw Deserves\n',
                              style: baseTextStyle?.copyWith(color: purple),
                            ),
                            TextSpan(
                              text: 'To Find Its Way Home — ',
                              style: baseTextStyle?.copyWith(color: orange),
                            ),
                            TextSpan(
                              text:
                                  '\nYour All-In-One App For Animal\nCare, Rescue, And Adoption',
                              style: baseTextStyle?.copyWith(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 120),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 26,
                            height: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(999),
                              gradient: const LinearGradient(
                                colors: [purple, orange],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: () => context.go('/login'),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: () => context.go('/register'),
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: _GoogleButton(
                        onTap: () {
                          // Google sign in
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
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

class _GoogleButton extends StatelessWidget {
  final VoidCallback onTap;

  const _GoogleButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF4B1A45);
    const orange = Color(0xFFE27D60);

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              colors: [purple, orange],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          padding: const EdgeInsets.all(1),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(17),
            ),
            child: RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                children: [
                  TextSpan(text: 'Sign in with '),
                  TextSpan(
                    text: 'Google',
                    style: TextStyle(color: orange),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
