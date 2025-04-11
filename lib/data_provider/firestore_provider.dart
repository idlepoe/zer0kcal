import 'package:cloud_firestore/cloud_firestore.dart';


class FirestoreProvider {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchRawPosts() async {
    final snapshot = await _db.collection('posts').get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
