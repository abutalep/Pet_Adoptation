import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hopepaw/features/Home/Data/models/animal_report.dart';

class EditService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String _collectionName = 'reports';

  static Future<void> updateReport(AnimalReport report) async {
    final docRef = _db.collection(_collectionName).doc(report.id);
    await docRef.update(report.toMap());
  }

  static Future<void> updateReportStatus(String reportId, String status) async {
    final docRef = _db.collection(_collectionName).doc(reportId);
    await docRef.update({'status': status});
  }
}
