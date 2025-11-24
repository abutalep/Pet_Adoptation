import 'package:flutter/material.dart';

class L10n {
  static final all = [const Locale('en'), const Locale('ar')];

  static String getLanguageName(String code) {
    switch (code) {
      case 'en':
        return "English";
      case 'ar':
        return "العربية";
      default:
        return "English";
    }
  }
}
