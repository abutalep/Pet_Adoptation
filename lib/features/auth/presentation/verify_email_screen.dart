import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/app_button.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final _codeControllers = List.generate(6, (_) => TextEditingController());
  bool _isLoading = false;

  Future<void> _onVerify() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);

    if (!mounted) return;
    context.go("/home");
  }

  @override
  void dispose() {
    for (final c in _codeControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Verify email")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Check your inbox",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "We sent a 6-digit code to your email.",
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  6,
                  (index) => SizedBox(
                    width: 40,
                    child: TextField(
                      controller: _codeControllers[index],
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(counterText: ""),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              AppButton(
                title: "Verify",
                isLoading: _isLoading,
                onPressed: _onVerify,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // TODO: resend code
                },
                child: const Text("Resend code"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
