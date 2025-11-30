import 'package:cloud_firestore/cloud_firestore.dart';

class DetailsService {
  static final _db = FirebaseFirestore.instance;

  static const reportCollectionName = 'reports';

  static Future<void> deleteReport(String reportId) async {
    final reportDoc = _db.collection(reportCollectionName).doc(reportId);
    await reportDoc.delete();
  }
}
