import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  static const String _languageKey = 'selected_language';
  Locale _locale = const Locale('en');

  Locale get locale => _locale;
  bool get isArabic => _locale.languageCode == 'ar';

  LanguageProvider() {
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final languageCode = prefs.getString(_languageKey);
      if (languageCode != null) {
        _locale = Locale(languageCode);
        notifyListeners();
      }
    } catch (e) {
      print('Error loading saved language: $e');
    }
  }

  Future<void> changeLanguage(Locale newLocale) async {
    if (_locale == newLocale) return;
    
    _locale = newLocale;
    notifyListeners();
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, newLocale.languageCode);
    } catch (e) {
      print('Error saving language: $e');
    }
  }

  // Translations
  String get(String key) {
    final translations = isArabic ? _arabicTranslations : _englishTranslations;
    return translations[key] ?? key;
  }

  static const Map<String, String> _englishTranslations = {
    // Common
    'continue': 'Continue',
    'save': 'Save',
    'cancel': 'Cancel',
    'next': 'Next',
    'back': 'Back',
    'login': 'Login',
    'signup': 'Sign up',
    'email': 'Email',
    'password': 'Password',
    'forgot_password': 'Forgot Password?',
    'create_account': 'Create an account',
    'first_name': 'First name',
    'last_name': 'Last name',
    'address': 'Address',
    'click_to_add_address': 'Click To Add Address',
    'do_you_have_pet': 'Do you have a pet?',
    'yes': 'Yes',
    'no': 'No',
    'accept_terms': 'I accept all terms & conditions and privacy policy',
    'choose_language': 'Choose Language',
    'select_language': 'Select a language to continue',
    'verification_email': 'Verification email',
    'email_verification': 'Email Verification',
    'code_sent': 'A verification link was sent to your email',
    'change_email': 'Change email',
    'verify_email': 'I\'ve verified my email',
    'resend_code': 'Resend',
    'resend_code_in': 'Resend code in',
    'didnt_receive': 'Didn\'t receive a code?',
    'required': 'Required',
    'invalid_email': 'Invalid email',
    'password_too_short': 'Password must be at least 8 characters',
    'password_requirements': 'Password requirements',
    'at_least_8': 'At Least 8 characters',
    'uppercase_lowercase': 'Both uppercase and lowercase letters(optional)',
    'number_symbol': 'At least one number or symbol(optional)',
    // Buttons
    'sign_in_with_google': 'Sign in with Google',
    'register': 'Register',
    'name_example': 'name@example.com',
    'your_password': 'Your Password',
    'please_enter_email': 'Please enter email',
    'please_enter_password': 'Please enter password',
    'password_min_6': 'Password must be at least 6 characters',
    'select_pet': 'Please select if you have a pet',
    'accept_terms_required': 'You must accept the terms and conditions',
  };

  static const Map<String, String> _arabicTranslations = {
    // Common
    'continue': 'متابعة',
    'save': 'حفظ',
    'cancel': 'إلغاء',
    'next': 'التالي',
    'back': 'رجوع',
    'login': 'تسجيل الدخول',
    'signup': 'إنشاء حساب',
    'email': 'البريد الإلكتروني',
    'password': 'كلمة المرور',
    'forgot_password': 'نسيت كلمة المرور؟',
    'create_account': 'إنشاء حساب',
    'first_name': 'الاسم الأول',
    'last_name': 'اسم العائلة',
    'address': 'العنوان',
    'click_to_add_address': 'اضغط لإضافة العنوان',
    'do_you_have_pet': 'هل لديك حيوان أليف؟',
    'yes': 'نعم',
    'no': 'لا',
    'accept_terms': 'أوافق على جميع الشروط والأحكام وسياسة الخصوصية',
    'choose_language': 'اختر اللغة',
    'select_language': 'اختر لغة للمتابعة',
    'verification_email': 'التحقق من البريد',
    'email_verification': 'التحقق من البريد الإلكتروني',
    'code_sent': 'تم إرسال رابط التحقق إلى بريدك الإلكتروني',
    'change_email': 'تغيير البريد',
    'verify_email': 'لقد قمت بالتحقق من بريدي',
    'resend_code': 'إعادة الإرسال',
    'resend_code_in': 'إعادة الإرسال خلال',
    'didnt_receive': 'لم تستلم الرابط؟',
    'required': 'مطلوب',
    'invalid_email': 'البريد الإلكتروني غير صحيح',
    'password_too_short': 'كلمة المرور يجب أن تكون 8 أحرف على الأقل',
    'password_requirements': 'متطلبات كلمة المرور',
    'at_least_8': '8 أحرف على الأقل',
    'uppercase_lowercase': 'أحرف كبيرة وصغيرة (اختياري)',
    'number_symbol': 'رقم أو رمز واحد على الأقل (اختياري)',
    // Buttons
    'sign_in_with_google': 'تسجيل الدخول بـ Google',
    'register': 'إنشاء حساب',
    'name_example': 'name@example.com',
    'your_password': 'كلمة المرور',
    'please_enter_email': 'الرجاء إدخال البريد الإلكتروني',
    'please_enter_password': 'الرجاء إدخال كلمة المرور',
    'password_min_6': 'كلمة المرور يجب أن تكون 6 أحرف على الأقل',
    'select_pet': 'الرجاء تحديد ما إذا كان لديك حيوان أليف',
    'accept_terms_required': 'يجب الموافقة على الشروط والأحكام',
  };
}

