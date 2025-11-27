import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hopepaw/features/Home/UI/screens/homescreen.dart';
import 'package:hopepaw/features/auth/Data/firebase/auth_service.dart';
import 'package:hopepaw/features/navigation/UI/screens/navigationScreen.dart';
import 'package:hopepaw/features/providers/language_provider.dart';
import 'package:hopepaw/features/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:math';

class EmailVerificationScreen extends StatefulWidget {
  final String email;
  final String password;
  
  const EmailVerificationScreen({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final _authService = AuthService();
  Timer? _timer;
  Timer? _checkTimer;
  int _secondsRemaining = 60;
  bool _isLoading = false;
  String _otpCode = '';

  @override
  void initState() {
    super.initState();
    _generateOtpCode();
    _startTimer();
    _startCheckingVerification();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _startCheckingVerification() {
    // التحقق من حالة التحقق كل 3 ثوانٍ
    _checkTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      final user = _authService.currentUser;
      if (user != null) {
        await user.reload();
        if (user.emailVerified && mounted) {
          timer.cancel();
          _timer?.cancel();
          // الانتقال للشاشة الرئيسية بعد ثانية
          await Future.delayed(const Duration(seconds: 1));
          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const NavigationScreen()),
            );
          }
        }
      }
    });
  }

  void _generateOtpCode() {
    final random = Random();
    _otpCode = List.generate(6, (_) => random.nextInt(10)).join();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _checkTimer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  Future<void> _checkVerification() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // تسجيل الدخول أولاً
      await _authService.signInWithEmailAndPassword(
        email: widget.email,
        password: widget.password,
      );

      // التحقق من حالة التحقق من البريد
      final user = _authService.currentUser;
      if (user != null) {
        await user.reload();
        
        if (user.emailVerified) {
          // تحميل بيانات المستخدم بعد التحقق
          final userProvider = Provider.of<UserProvider>(context, listen: false);
          await userProvider.loadUserData();
          
          if (mounted) {
            _checkTimer?.cancel();
            _timer?.cancel();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('لم يتم التحقق من البريد بعد. يرجى فتح الرابط المرسل إلى بريدك الإلكتروني'),
                backgroundColor: Colors.orange,
                duration: Duration(seconds: 3),
              ),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: Colors.red,
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

  Future<void> _resendCode() async {
    if (_secondsRemaining > 0) {
      return;
    }

    setState(() {
      _isLoading = true;
      _secondsRemaining = 60;
    });
    _startTimer();

    try {
      // تسجيل الدخول أولاً لإرسال رابط التحقق
      await _authService.signInWithEmailAndPassword(
        email: widget.email,
        password: widget.password,
      );
      
      await _authService.sendEmailVerification();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم إرسال رابط التحقق مرة أخرى إلى بريدك الإلكتروني'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: Colors.red,
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
    final lang = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8), // Light beige background
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // "Verfication email" text at top left
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 4.0),
                    child: Text(
                      lang.get('verification_email'),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[500],
                        fontFamily: 'sans-serif',
                      ),
                    ),
                  ),

                  const Spacer(),

                  // White panel with shadow
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(32.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        // Logo - centered
                        SvgPicture.asset(
                          'assets/path7000.svg',
                          width: 80,
                          height: 80,
                        ),

                        const SizedBox(height: 24),

                        // "Email Verification" title
                        const Text(
                          'Email Verification',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8B3A62), // Reddish-purple
                            fontFamily: 'sans-serif',
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Instructional text
                        Text(
                          lang.get('code_sent'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontFamily: 'sans-serif',
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Email display
                        Text(
                          widget.email,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                            fontFamily: 'sans-serif',
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Removed random numbers row as requested

                        const SizedBox(height: 24),

                        // Instructions
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF8C00).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFFF8C00).withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.info_outline,
                                color: Color(0xFFFF8C00),
                                size: 24,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                lang.isArabic
                                    ? 'من فضلك افتح بريدك الإلكتروني واضغط على رابط التحقق الذي أرسلناه لك'
                                    : 'Please check your email and click on the verification link we sent you',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontFamily: 'sans-serif',
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                lang.isArabic
                                    ? 'سيقوم التطبيق بالتحقق تلقائياً من بريدك الإلكتروني بعد فتح الرابط'
                                    : 'The app will automatically verify your email after you open the link',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                  fontFamily: 'sans-serif',
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Resend timer
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${lang.get('resend_code_in')} ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontFamily: 'sans-serif',
                              ),
                            ),
                            Text(
                              _formatTime(_secondsRemaining),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFFF8C00), // Orange
                                fontFamily: 'sans-serif',
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // Verify button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _checkVerification,
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
                                : Text(
                                    lang.get('verify_email'),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'sans-serif',
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Resend link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${lang.get('didnt_receive')} ",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontFamily: 'sans-serif',
                              ),
                            ),
                            TextButton(
                              onPressed: _secondsRemaining == 0 ? _resendCode : null,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                'Resend',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFFF8C00), // Orange
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'sans-serif',
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),

                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

