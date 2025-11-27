import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hopepaw/features/report/Data/models/report_model.dart';

class ReportService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SupabaseClient _supabase = Supabase.instance.client;

  static const String _collectionName = 'reports';
  static const String _bucketName = 'images'; // اسم الباكت في Supabase

  // رفع الصور إلى Supabase وإرجاع روابطها العامة
  Future<List<String>> uploadImagesToSupabase(List<String> imagePaths) async {
    List<String> urls = [];

    try {
      for (var i = 0; i < imagePaths.length; i++) {
        final file = File(imagePaths[i]);

        final fileName = '${DateTime.now().millisecondsSinceEpoch}_$i.jpg';
        // رفع الصورة
        final response = await _supabase.storage
            .from(_bucketName)
            .upload(fileName, file);

        // جلب رابط الصورة
        final publicUrl = _supabase.storage
            .from(_bucketName)
            .getPublicUrl(fileName);

        urls.add(publicUrl);
      }
    } catch (e) {
      throw Exception("error in uploading  $e");
    }

    return urls;
  }

  /// حفظ التقرير في Firestore مع روابط الصور من Supabase
  Future<String> submitReport(AnimalReport report) async {
    try {
      // 1) رفع الصور لـ Supabase فقط
      List<String>? imageUrls;
      if (report.images != null && report.images!.isNotEmpty) {
        imageUrls = await uploadImagesToSupabase(report.images!);
      }

      // 2) تجهيز البيانات
      Map<String, dynamic> data = report.toMap();

      if (imageUrls != null) {
        data['images'] = imageUrls;
      }


      // 3) تخزين في Firestore
      DocumentReference docRef = await _firestore
          .collection(_collectionName)
          .add(data);

      // 4) تأكد أن حقل 'id' داخل المستند يتوافق مع معرف المستند الذي أنشأه Firestore
      // هذا يساعد عند القراءة على عدم وجود تناقض بين الحقل الداخلي ومعرف المستند
      await docRef.update({'id': docRef.id});

      return docRef.id;
    } catch (e) {
      throw Exception("$e");
    }
  }
}
