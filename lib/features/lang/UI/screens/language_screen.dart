import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hopepaw/features/permission/UI/screen/permissions_screen.dart';
import 'package:hopepaw/features/providers/language_provider.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String? _selectedLanguageCode;

  final List<Map<String, dynamic>> _languages = [
    {
      'code': 'en',
      'name': 'English',
      'nativeName': 'English',
      'flag': '🇬🇧',
    },
    {
      'code': 'ar',
      'name': 'Arabic',
      'nativeName': 'العربية',
      'flag': '🇸🇦',
    },
  ];

  @override
  void initState() {
    super.initState();
    // تحميل اللغة المحفوظة
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    setState(() {
      _selectedLanguageCode = languageProvider.locale.languageCode;
    });
  }


  void _handleContinue() {
    if (_selectedLanguageCode != null) {
      // تغيير لغة التطبيق قبل الانتقال
      final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
      languageProvider.changeLanguage(Locale(_selectedLanguageCode!));
      
      // الانتقال بعد تغيير اللغة
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const PermissionsScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const darkPurple = Color(0xFF44174E);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8), // Light beige background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Title at top
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Choose Language',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF44174E), // Dark purple
                    fontFamily: 'sans-serif',
                  ),
                ),
              ),

              const Spacer(),

              // Logo
              SvgPicture.asset(
                'assets/Frame 208.svg',
                width: 150,
                height: 150,
              ),

              const SizedBox(height: 24),

              // App Name
              const Text(
                'HopePaw',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF44174E), // Dark purple
                  fontFamily: 'sans-serif',
                ),
              ),

              const SizedBox(height: 40),

              // Language Dropdown
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedLanguageCode,
                    isExpanded: true,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: darkPurple,
                      size: 28,
                    ),
                    hint: const Text(
                      'Choose a language',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontFamily: 'sans-serif',
                      ),
                    ),
                    items: _languages.map((language) {
                      return DropdownMenuItem<String>(
                        value: language['code'] as String,
                        child: Text(
                          language['nativeName'] as String,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontFamily: 'sans-serif',
                          ),
                        ),
                      );
                    }).toList(),
                      onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedLanguageCode = newValue;
                        });
                        // تغيير اللغة فوراً عند الاختيار
                        final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
                        languageProvider.changeLanguage(Locale(newValue));
                      }
                    },
                  ),
                ),
              ),

              const Spacer(),

              // Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedLanguageCode != null ? _handleContinue : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                    disabledBackgroundColor: Colors.grey[300],
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'sans-serif',
                    ),
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
