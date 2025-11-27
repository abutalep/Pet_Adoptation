import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  static const String _languageKey = 'selected_language';
  static const Locale _defaultLocale = Locale('en');

  /// الحصول على اللغة المحفوظة
  static Future<Locale> getSavedLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final languageCode = prefs.getString(_languageKey);
      
      if (languageCode != null) {
        return Locale(languageCode);
      }
    } catch (e) {
      print('Error loading saved language: $e');
    }
    
    return _defaultLocale;
  }

  /// حفظ اللغة المختارة
  static Future<void> saveLanguage(Locale locale) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, locale.languageCode);
    } catch (e) {
      print('Error saving language: $e');
    }
  }

  /// الحصول على اللغة الافتراضية
  static Locale getDefaultLocale() {
    return _defaultLocale;
  }

  /// قائمة اللغات المدعومة
  static List<Locale> getSupportedLocales() {
    return const [
      Locale('en'),
      Locale('ar'),
    ];
  }
}


