import 'package:flutter/material.dart';
import '../auth/Data/firebase/auth_service.dart';

class UserProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  
  Map<String, dynamic>? _userData;
  bool _isLoading = false;

  Map<String, dynamic>? get userData => _userData;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _authService.currentUser != null;

  // جلب بيانات المستخدم الحالي
  Future<void> loadUserData() async {
    final user = _authService.currentUser;
    if (user == null) {
      _userData = null;
      notifyListeners();
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      _userData = await _authService.getUserData(user.uid);
    } catch (e) {
      print('Error loading user data: $e');
      _userData = null;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // تحديث بيانات المستخدم
  Future<void> updateUserData({
    String? firstName,
    String? lastName,
    String? address,
    bool? hasPet,
    String? profileImageUrl,
  }) async {
    final user = _authService.currentUser;
    if (user == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await _authService.saveUserData(
        userId: user.uid,
        email: user.email ?? '',
        firstName: firstName ?? _userData?['firstName'] ?? '',
        lastName: lastName ?? _userData?['lastName'] ?? '',
        address: address ?? _userData?['address'] ?? '',
        hasPet: hasPet ?? _userData?['hasPet'] ?? false,
        profileImageUrl: profileImageUrl ?? _userData?['profileImageUrl'] ?? '',
      );
      
      // إعادة تحميل البيانات
      await loadUserData();
    } catch (e) {
      print('Error updating user data: $e');
      rethrow;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // مسح بيانات المستخدم
  void clearUserData() {
    _userData = null;
    notifyListeners();
  }

  void setState(VoidCallback fn) {
    fn();
    notifyListeners();
  }
}

