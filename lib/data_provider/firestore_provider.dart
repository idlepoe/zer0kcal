import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zer0kcal/features/result/models/calorie_result.dart';

import '../core/logger.dart';

class FirestoreProvider {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchRawPosts() async {
    final snapshot = await _db.collection('feed').get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<bool> uploadPost({required CalorieResult calorieResult}) async {
    try {
      var addResult = await _db.collection('feed').add({
        ...calorieResult.toJson(),
        "createdAt": DateTime.now(),
      });
    } catch (e) {
      logger.e(e);
    }
    return true;
  }
}
