import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hopepaw/features/Home/Data/models/animal_report.dart';

class HomeFirebase {
  static final _db = FirebaseFirestore.instance;
  static const usersCollectionName = 'users';
  static const reportsCollectionName = 'reports';

  // static Stream <List<AnimalReport>> getAllPosts() {
  //   final userId = FirebaseAuth.instance.currentUser?.uid;
  //   if (userId == null) {
  //     throw "No User Logged In";
  //   }
  //   final postsCollection = _db.collection(postsCollectionName);
  //   final postsDataStream = postsCollection.snapshots();
  //   final postsStream = postsDataStream.map((e) {
  //     final postsDocs = e.docs;
  //     final posts = postsDocs.map((e) {
  //       final postMap = e.data();
  //       return AnimalReport.fromMap(postMap);
  //     });
  //     return posts.toList();
  //   });
  //   return postsStream;
  // }

  static Stream<List<AnimalReport>> getPostsByCategory({
    String category = 'All',
    String status = 'All',
  }) {
    final reportsCollection = _db.collection(reportsCollectionName);
    Query reportsQuery = reportsCollection;

    if (category != 'All') {
      reportsQuery = reportsQuery.where('category', isEqualTo: category);
    }
    if (status != 'All') {
      reportsQuery = reportsQuery.where('status', isEqualTo: status);
    }

    return reportsQuery.snapshots().map(
      (snapshot) => snapshot.docs
          .map(
            (doc) => AnimalReport.fromMap(doc.data() as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
