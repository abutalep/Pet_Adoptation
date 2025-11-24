import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _isLoading = false;
  bool _hasPet = false;

  Future<void> _onRegister() async {
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 1));

    setState(() => _isLoading = false);

    if (!mounted) return;
    context.go("/verify-email");
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Create account")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Join HopePaw",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              AppTextField(label: "First name", controller: _firstName),
              const SizedBox(height: 16),
              AppTextField(label: "Last name", controller: _lastName),
              const SizedBox(height: 16),
              AppTextField(
                label: "Email",
                hint: "name@example.com",
                controller: _email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: "Password",
                hint: "At least 8 characters",
                controller: _password,
                obscure: true,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Switch(
                    value: _hasPet,
                    onChanged: (val) => setState(() => _hasPet = val),
                  ),
                  const SizedBox(width: 8),
                  const Text("I already have a pet"),
                ],
              ),
              const SizedBox(height: 24),
              AppButton(
                title: "Create account",
                isLoading: _isLoading,
                onPressed: _onRegister,
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () => context.go("/login"),
                  child: const Text("Already have an account? Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
