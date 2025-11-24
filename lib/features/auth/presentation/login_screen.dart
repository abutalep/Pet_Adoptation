import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _onLogin() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));

    setState(() => _isLoading = false);

    if (!mounted) return;
    context.go("/home");
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(flex: 2),
              SizedBox(
                height: 130,
                width: 130,
                child: Image.asset(
                  'assets/image/image.png',
                  fit: BoxFit.contain,
                ),
              ),

              // Spacer(flex: 1),
              const Text(
                "HopePaw",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF4B1A45),
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                "Welcome back 👋",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Login to HopePaw to help pets find their home.",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 32),

              AppTextField(
                label: "Email",
                hint: "name@example.com",
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              const SizedBox(height: 16),

              AppTextField(
                label: "Password",
                hint: "Your password",
                controller: _passwordController,
                obscure: true,
                prefixIcon: const Icon(Icons.lock_outline),
              ),
              const SizedBox(height: 24),

              AppButton(
                title: "Login",
                isLoading: _isLoading,
                onPressed: _onLogin,
              ),

              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    // لاحقاً: go to /register
                  },
                  child: const Text("Don’t have an account? Register"),
                ),
              ),
              Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
