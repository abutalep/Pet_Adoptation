import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';

import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Auth state stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// تسجيل الدخول بالبريد الإلكتروني وكلمة المرور
  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('حدث خطأ أثناء تسجيل الدخول: $e');
    }
  }

  /// رفع الصورة الشخصية إلى Firebase Storage
  Future<String?> uploadProfileImage(Uint8List imageBytes, String userId) async {
    try {
      final fileName = 'profile_images/$userId/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final ref = _storage.ref(fileName);
      
      final uploadTask = ref.putData(
        imageBytes,
        SettableMetadata(contentType: 'image/jpeg'),
      );
      
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      
      return downloadUrl;
    } catch (e) {
      print('Error uploading profile image: $e');
      return null;
    }
  }

  /// حفظ بيانات المستخدم الكاملة في Firestore
  Future<void> saveUserData({
    required String userId,
    required String email,
    required String firstName,
    required String lastName,
    String? address,
    bool? hasPet,
    String? profileImageUrl,
  }) async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'email': email.trim(),
        'firstName': firstName.trim(),
        'lastName': lastName.trim(),
        'displayName': '${firstName.trim()} ${lastName.trim()}',
        'address': address?.trim() ?? '',
        'hasPet': hasPet ?? false,
        'profileImageUrl': profileImageUrl ?? '',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception('حدث خطأ أثناء حفظ بيانات المستخدم: $e');
    }
  }

  /// جلب بيانات المستخدم من Firestore
  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return doc.data();
      }
      return null;
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  /// تسجيل حساب جديد
  Future<UserCredential?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      // تحديث اسم المستخدم إذا تم توفيره
      if (displayName != null && displayName.isNotEmpty) {
        await userCredential.user?.updateDisplayName(displayName);
        await userCredential.user?.reload();
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('حدث خطأ أثناء إنشاء الحساب: $e');
    }
  }

  /// إرسال رابط إعادة تعيين كلمة المرور
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('حدث خطأ أثناء إرسال رابط إعادة تعيين كلمة المرور: $e');
    }
  }

  /// إرسال رابط التحقق من البريد الإلكتروني
  Future<void> sendEmailVerification() async {
    try {
      final user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      } else {
        throw Exception('المستخدم غير موجود أو تم التحقق من البريد مسبقاً');
      }
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('حدث خطأ أثناء إرسال رابط التحقق: $e');
    }
  }

  /// التحقق من رمز التحقق من البريد (عن طريق إعادة تسجيل الدخول)
  Future<void> verifyEmail(String email, String password) async {
    try {
      // تسجيل الدخول للتحقق من البريد
      await signInWithEmailAndPassword(email: email, password: password);
      
      // التحقق من حالة التحقق من البريد
      final user = _auth.currentUser;
      if (user != null) {
        await user.reload();
        if (!user.emailVerified) {
          throw Exception('لم يتم التحقق من البريد الإلكتروني بعد');
        }
      }
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('حدث خطأ أثناء التحقق من البريد: $e');
    }
  }

  /// تسجيل الدخول بحساب Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // تسجيل الدخول في Firebase باستخدام بيانات Google
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      throw Exception('حدث خطأ أثناء تسجيل الدخول بـ Google: $e');
    }
  }


  /// تسجيل الخروج
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('حدث خطأ أثناء تسجيل الخروج: $e');
    }
  }

  /// حذف الحساب
  Future<void> deleteAccount() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        // حذف بيانات المستخدم من Firestore
        await _firestore.collection('users').doc(user.uid).delete();
        // حذف الحساب
        await user.delete();
      }
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('حدث خطأ أثناء حذف الحساب: $e');
    }
  }

  /// تحديث كلمة المرور
  Future<void> updatePassword(String newPassword) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
      } else {
        throw Exception('المستخدم غير مسجل دخول');
      }
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('حدث خطأ أثناء تحديث كلمة المرور: $e');
    }
  }

  /// تحديث البريد الإلكتروني
  Future<void> updateEmail(String newEmail) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await user.verifyBeforeUpdateEmail(newEmail.trim());
      } else {
        throw Exception('المستخدم غير مسجل دخول');
      }
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('حدث خطأ أثناء تحديث البريد الإلكتروني: $e');
    }
  }

  /// معالجة أخطاء Firebase Auth وإرجاع رسالة واضحة
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'كلمة المرور ضعيفة جداً';
      case 'email-already-in-use':
        return 'البريد الإلكتروني مستخدم بالفعل';
      case 'user-not-found':
        return 'البريد الإلكتروني غير مسجل';
      case 'wrong-password':
        return 'كلمة المرور خاطئة';
      case 'invalid-email':
        return 'البريد الإلكتروني غير صحيح';
      case 'user-disabled':
        return 'تم تعطيل هذا الحساب';
      case 'too-many-requests':
        return 'عدد محاولات كثيرة جداً. الرجاء المحاولة لاحقاً';
      case 'operation-not-allowed':
        return 'هذه العملية غير مسموحة';
      case 'requires-recent-login':
        return 'يجب تسجيل الدخول مرة أخرى لإكمال هذه العملية';
      default:
        return e.message ?? 'حدث خطأ غير متوقع';
    }
  }
}


