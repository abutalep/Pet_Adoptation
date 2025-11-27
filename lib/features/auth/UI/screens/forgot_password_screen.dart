import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hopepaw/features/auth/Data/firebase/auth_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
    // إخفاء لوحة المفاتيح
    FocusScope.of(context).unfocus();
    
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final email = _emailController.text.trim();
      await _authService.sendPasswordResetEmail(email);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم إرسال رابط إعادة تعيين كلمة المرور إلى $email'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 4),
          ),
        );
        // الانتظار قليلاً قبل الرجوع
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) {
          Navigator.of(context).pop();
        }
      }
    } catch (e) {
      if (mounted) {
        String errorMessage = e.toString().replaceAll('Exception: ', '');
        if (errorMessage.contains('user-not-found')) {
          errorMessage = 'البريد الإلكتروني غير مسجل';
        } else if (errorMessage.contains('invalid-email')) {
          errorMessage = 'البريد الإلكتروني غير صحيح';
        }
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8), // Light beige background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // "forgot Password" text at top left
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 4.0),
                child: Text(
                  'forgot Password',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[500],
                    fontFamily: 'sans-serif',
                  ),
                ),
              ),

              const Spacer(),

              // White panel
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                    const SizedBox(height: 20),

                    // Logo - centered
                    SvgPicture.asset(
                      'assets/Frame 208.svg',
                      width: 120,
                      height: 120,
                    ),

                    const SizedBox(height: 24),

                    // "Forgot Password" title
                    const Text(
                      'Forgot Password',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF44174E), // Dark purple
                        fontFamily: 'sans-serif',
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Email field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                            fontFamily: 'sans-serif',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0E0E0), // Light grey
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء إدخال البريد الإلكتروني';
                              }
                              if (!value.contains('@')) {
                                return 'البريد الإلكتروني غير صحيح';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.mail_outline,
                                color: Colors.grey,
                              ),
                              hintText: 'name@example.com',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontFamily: 'sans-serif',
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // Next button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleResetPassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF44174E), // Dark purple
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                          disabledBackgroundColor: Colors.grey[300],
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text(
                                'NEXT',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.2,
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

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

