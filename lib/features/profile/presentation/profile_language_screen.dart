import 'package:flutter/material.dart';

class ProfileLanguageScreen extends StatefulWidget {
  const ProfileLanguageScreen({super.key});

  @override
  State<ProfileLanguageScreen> createState() => _ProfileLanguageScreenState();
}

class _ProfileLanguageScreenState extends State<ProfileLanguageScreen> {
  final List<String> _languages = const [
    'English',
    'Arabic',
    'French',
    'German',
  ];

  String _selected = 'English';

  @override
  Widget build(BuildContext context) {
    const lightPurple = Color(0xFFF6ECF3);
    const purple = Color(0xFF4B1A45);

    return Scaffold(
      backgroundColor: lightPurple,
      appBar: AppBar(
        backgroundColor: lightPurple,
        elevation: 0,
        leading: const BackButton(color: purple),
        title: const Text(
          'Choose language',
          style: TextStyle(color: purple, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              padding: const EdgeInsets.all(16),
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Choose a language',
                      labelStyle: const TextStyle(color: Color(0xFFB4A4B8)),
                      filled: true,
                      fillColor: const Color(0xFFF5F2F7),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFFE0D2EA),
                          width: 1.2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFFE0D2EA),
                          width: 1.2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: purple, width: 1.4),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selected,
                        isExpanded: true,
                        onChanged: (val) {
                          if (val == null) return;
                          setState(() => _selected = val);
                          // هنا ممكن تحفظ اللغة في shared prefs / provider
                        },
                        items: _languages
                            .map(
                              (lang) => DropdownMenuItem<String>(
                                value: lang,
                                child: Text(lang),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
