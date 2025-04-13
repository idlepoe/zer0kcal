import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zer0kcal/features/result/models/calorie_result.dart';

import '../core/constants/api_constants.dart';
import '../core/dio.dart';
import '../core/logger.dart';
import '../core/utils/app_utils.dart';

class FirestoreProvider {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getFeedList() async {
    try {
      final response = await dio.get(ApiConstants.getFeed);

      final data = response.data;
      final List<dynamic> rows = data['result'];

      return rows.cast<Map<String, dynamic>>();
    } catch (e) {
      print("에러 발생: $e");
      rethrow;
    }
  }

  Future<bool> writeFeed({required CalorieResult param}) async {
    try {
      final response = await dio.get(
        ApiConstants.writeFeed,
        data: param.toJson(),
      );
      if (response.statusCode != 200) {
        throw ("에러");
      }
    } catch (e) {
      print("에러 발생: $e");
      return false;
    }
    return true;
  }
}
