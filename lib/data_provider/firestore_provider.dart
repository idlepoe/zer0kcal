import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zer0kcal/features/result/models/calorie_result.dart';

import '../core/logger.dart';
import '../core/utils/app_utils.dart';

class FirestoreProvider {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchFeed() async {
    final snapshot =
        await _db
            .collection('feed')
            .orderBy("createdAt", descending: true)
            .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<bool> uploadPost({required CalorieResult calorieResult}) async {
    try {
      var addResult = await _db.collection('feed').add({
        ...calorieResult.toJson(),
        "id": AppUtils.getDateTimeKey(),
        "createdAt": DateTime.now(),
      });
    } catch (e) {
      logger.e(e);
    }
    return true;
  }
}
