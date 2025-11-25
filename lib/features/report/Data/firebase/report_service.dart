import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hopepaw/features/report/Data/models/post_model.dart';

class ReportService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Collection name in Firestore
  static const String _collectionName = 'animal_reports';

  /// رفع الصور إلى Firebase Storage وإرجاع روابطها
  Future<List<String>> uploadImages(List<String> imagePaths) async {
    List<String> imageUrls = [];

    try {
      for (int i = 0; i < imagePaths.length; i++) {
        String fileName =
            'reports/${DateTime.now().millisecondsSinceEpoch}_$i.jpg';
        File imageFile = File(imagePaths[i]);

        // رفع الصورة
        TaskSnapshot snapshot = await _storage.ref(fileName).putFile(imageFile);

        // الحصول على رابط الصورة
        String downloadUrl = await snapshot.ref.getDownloadURL();
        imageUrls.add(downloadUrl);
      }
    } catch (e) {
      throw Exception('فشل رفع الصور: $e');
    }

    return imageUrls;
  }

  /// حفظ التقرير في Firestore
  /// هذه الدالة تستخدم فقط الوظائف التي يحتاجها الـ report screen
  Future<String> submitReport(AnimalReport report) async {
    try {
      // رفع الصور أولاً إذا كانت موجودة
      List<String>? imageUrls;
      if (report.images != null && report.images!.isNotEmpty) {
        imageUrls = await uploadImages(report.images!);
      }

      // إعداد بيانات التقرير
      Map<String, dynamic> reportData = report.toMap();

      // استبدال مسارات الصور المحلية بروابط Firebase Storage
      if (imageUrls != null) {
        reportData['images'] = imageUrls;
      }

      // إضافة timestamp من Firestore
      reportData['createdAt'] = FieldValue.serverTimestamp();
      reportData['updatedAt'] = FieldValue.serverTimestamp();

      // حفظ التقرير في Firestore
      DocumentReference docRef = await _firestore
          .collection(_collectionName)
          .add(reportData);

      return docRef.id;
    } catch (e) {
      throw Exception('$e');
    }
  }

}
