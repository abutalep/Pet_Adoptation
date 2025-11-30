import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hopepaw/features/Home/Data/models/animal_report.dart';

class AdoptionServices {
  static final _db = FirebaseFirestore.instance;
  static const reportsCollectionName = 'reports';
  static const adoptionStatus = 'Adoption';

  static Stream<List<AnimalReport>> getAdoptionReportsByCategory(
    String category,
  ) {
    final reportsCollection = _db.collection(reportsCollectionName);

    if (category == 'All') {
      return reportsCollection
          .where('status', isEqualTo: adoptionStatus)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map((d) => AnimalReport.fromMap(d.data()))
                .toList(),
          );
    }

    final filtered = reportsCollection
        .where('status', isEqualTo: adoptionStatus)
        .where('category', isEqualTo: category)
        .snapshots();

    return filtered.map(
      (snapshot) =>
          snapshot.docs.map((d) => AnimalReport.fromMap(d.data())).toList(),
    );
  }
}
