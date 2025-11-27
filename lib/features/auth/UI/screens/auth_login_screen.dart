import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hopepaw/features/auth/Data/firebase/auth_service.dart';
import 'package:hopepaw/features/navigation/UI/screens/navigationScreen.dart';
import 'package:hopepaw/features/providers/language_provider.dart';
import 'package:hopepaw/features/providers/user_provider.dart';
import 'package:hopepaw/features/auth/UI/screens/forgot_password_screen.dart';
import 'package:provider/provider.dart';
import 'signup_screen.dart';

class AuthLoginScreen extends StatefulWidget {
  const AuthLoginScreen({super.key});

  @override
  State<AuthLoginScreen> createState() => _AuthLoginScreenState();
}

class _AuthLoginScreenState extends State<AuthLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _authService.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // تحميل بيانات المستخدم بعد تسجيل الدخول
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.loadUserData();

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const NavigationScreen()),
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
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF5F0E8), // Light beige background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // "Log in" text at top left
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 4.0),
                  child: Text(
                    'Log in',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[500],
                      fontFamily: 'sans-serif',
                    ),
                  ),
                ),
            
                const SizedBox(height: 40),
            
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
            
                        // "Login/Registration" title
                        const Text(
                          'Login/Registration',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5C1F6E), // Dark purple
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
                                  hintText: lang.get('name_example'),
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
            
                        const SizedBox(height: 24),
            
                        // Password field
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Password',
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
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'الرجاء إدخال كلمة المرور';
                                  }
                                  if (value.length < 6) {
                                    return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.lock_outline,
                                    color: Colors.grey,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                  hintText: lang.get('your_password'),
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
            
                        const SizedBox(height: 12),
            
                        // Forgot password link
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen(),
                                ),
                              );
                            },
                            child: Text(
                              lang.get('forgot_password'),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFFD2691E), // Orange-brown
                                fontFamily: 'sans-serif',
                              ),
                            ),
                          ),
                        ),
            
                        const SizedBox(height: 32),
            
                        // Login button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(
                                0xFF5C1F6E,
                              ), // Dark purple
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
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : Text(
                                    lang.get('login'),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'sans-serif',
                                    ),
                                  ),
                          ),
                        ),
            
                        const SizedBox(height: 24),
            
                        // Registration prompt
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                                fontFamily: 'sans-serif',
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const SignupScreen(),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                lang.get('register'),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFD2691E), // Orange-brown
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
                ),
            
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
