import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({super.key});

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  String _lang = "en";

  void _continue() {
    context.go("/permissions-info");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 3),
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
              Spacer(flex: 1),
              DropdownButtonFormField<String>(
                initialValue: _lang,
                items: const [
                  DropdownMenuItem(value: "en", child: Text("English")),
                  DropdownMenuItem(value: "ar", child: Text("العربية")),
                ],
                onChanged: (v) => setState(() => _lang = v ?? "en"),
                decoration: const InputDecoration(
                  labelText: "Choose a language",
                ),
              ),
              Spacer(flex: 2),
              //    const SizedBox(height: 20),
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
                  onPressed: _continue,
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
