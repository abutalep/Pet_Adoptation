import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hopepaw/features/auth/Data/firebase/auth_service.dart';
import 'package:hopepaw/features/providers/language_provider.dart';
import 'package:hopepaw/features/auth/UI/screens/email_verification_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:typed_data';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _addressController = TextEditingController();
  final _authService = AuthService();
  final _imagePicker = ImagePicker();
  Uint8List? _profileImageBytes;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool? _petSelected; // null = not selected, true = yes, false = no
  bool _acceptTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickProfileImage() async {
    try {
      // محاولة اختيار الصورة من المعرض
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );

      if (image != null) {
        final bytes = await image.readAsBytes();
        setState(() {
          _profileImageBytes = bytes;
        });
      }
    } catch (e) {
      // إذا فشل من المعرض، جرب الكاميرا
      try {
        final XFile? image = await _imagePicker.pickImage(
          source: ImageSource.camera,
          maxWidth: 512,
          maxHeight: 512,
          imageQuality: 85,
        );

        if (image != null) {
          final bytes = await image.readAsBytes();
          setState(() {
            _profileImageBytes = bytes;
          });
        }
      } catch (e2) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('حدث خطأ: يرجى التحقق من صلاحيات الوصول للصور'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_petSelected == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الرجاء تحديد ما إذا كان لديك حيوان أليف'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يجب الموافقة على الشروط والأحكام'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final fullName = '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}';
      
      // إنشاء الحساب
      final userCredential = await _authService.signUpWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        displayName: fullName,
      );

      if (userCredential?.user == null) {
        throw Exception('فشل إنشاء الحساب');
      }

      final userId = userCredential!.user!.uid;
      String? profileImageUrl;

      // رفع الصورة الشخصية إذا كانت موجودة
      if (_profileImageBytes != null) {
        profileImageUrl = await _authService.uploadProfileImage(
          _profileImageBytes!,
          userId,
        );
      }

      // حفظ بيانات المستخدم الكاملة في Firestore
      await _authService.saveUserData(
        userId: userId,
        email: _emailController.text.trim(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        address: _addressController.text.trim(),
        hasPet: _petSelected ?? false,
        profileImageUrl: profileImageUrl,
      );

      // إرسال رابط التحقق من البريد
      await _authService.sendEmailVerification();

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => EmailVerificationScreen(
              email: _emailController.text.trim(),
              password: _passwordController.text,
            ),
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
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // "Sign up" text at top left
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 4.0),
                child: Text(
                  lang.get('signup'),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[500],
                    fontFamily: 'sans-serif',
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // White panel with form
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with back button, title, and profile icon
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: Color(0xFF44174E)),
                            onPressed: () => Navigator.of(context).pop(),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          Expanded(
                            child:                             Text(
                              lang.get('create_account'),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF44174E), // Dark purple
                                fontFamily: 'sans-serif',
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: _pickProfileImage,
                            child: Stack(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFF44174E), // Dark purple
                                        Color(0xFFD2691E), // Orange
                                      ],
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(3),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: _profileImageBytes != null
                                        ? ClipOval(
                                            child: Image.memory(
                                              _profileImageBytes!,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : Center(
                                            child: SvgPicture.asset(
                                              'assets/Frame 175.svg',
                                              width: 40,
                                              height: 40,
                                            ),
                                          ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF44174E), // Dark purple
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // First name and Last name in a row
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE0E0E0), // Light grey
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: TextFormField(
                                    controller: _firstNameController,
                                    decoration: InputDecoration(
                                      hintText: lang.get('first_name'),
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
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Required';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE0E0E0), // Light grey
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: TextFormField(
                                    controller: _lastNameController,
                                    decoration: InputDecoration(
                                      hintText: lang.get('last_name'),
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
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Required';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Email field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                hintText: lang.get('email'),
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
                                if (value.length < 8) {
                                  return 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';
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
                                hintText: lang.get('password'),
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
                          const SizedBox(height: 12),
                          // Password requirements
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildRequirement(lang.get('at_least_8')),
                              _buildRequirement(lang.get('uppercase_lowercase')),
                              _buildRequirement(lang.get('number_symbol')),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Confirm Password field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFE0E0E0), // Light grey
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: _obscureConfirmPassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'الرجاء تأكيد كلمة المرور';
                                }
                                if (value != _passwordController.text) {
                                  return 'كلمة المرور غير متطابقة';
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
                                    _obscureConfirmPassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureConfirmPassword = !_obscureConfirmPassword;
                                    });
                                  },
                                ),
                                hintText: lang.get('confirm_password') ?? 'Confirm Password',
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

                      // Address field
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0E0E0), // Light grey
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextFormField(
                          controller: _addressController,
                          decoration: InputDecoration(
                            hintText: lang.get('address'),
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

                      const SizedBox(height: 12),

                      // Click To Add Address button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Handle address selection
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF44174E), // Dark purple
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            lang.get('click_to_add_address'),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'sans-serif',
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Do you have a pet?
                      Row(
                        children: [
                          Text(
                            lang.get('do_you_have_pet'),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                              fontFamily: 'sans-serif',
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              _buildPetButton(lang.get('yes'), true),
                              const SizedBox(width: 12),
                              _buildPetButton(lang.get('no'), false),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Terms and conditions checkbox
                      Row(
                        children: [
                          Checkbox(
                            value: _acceptTerms,
                            onChanged: (value) {
                              setState(() {
                                _acceptTerms = value ?? false;
                              });
                            },
                            activeColor: const Color(0xFF44174E),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _acceptTerms = !_acceptTerms;
                                });
                              },
                              child: Text(
                                lang.get('accept_terms'),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontFamily: 'sans-serif',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Save button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleSignup,
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
                                  lang.get('save'),
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

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequirement(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            size: 6,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontFamily: 'sans-serif',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPetButton(String label, bool value) {
    final isSelected = _petSelected == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _petSelected = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF7B61FF).withOpacity(0.3) // Selected - darker
              : const Color(0xFF7B61FF).withOpacity(0.2), // Not selected - lighter
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF7B61FF) // Selected - solid border
                : const Color(0xFF7B61FF).withOpacity(0.3), // Not selected - light border
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected
                ? const Color(0xFF44174E) // Selected - dark purple
                : const Color(0xFF7B61FF), // Not selected - light purple
            fontFamily: 'sans-serif',
          ),
        ),
      ),
    );
  }
}

