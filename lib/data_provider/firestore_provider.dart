import 'package:zer0kcal/features/result/models/calorie_result.dart';

import '../core/constants/api_constants.dart';
import '../core/dio.dart';
import '../features/feed/models/comment.dart';

class FirestoreProvider {
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

  Future<Map<String, dynamic>> getFeedDetail({
    required String feedID,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.getFeedDetail,
        data: {"feed_id": feedID},
      );

      final data = response.data;

      return data['result'];
    } catch (e) {
      print("에러 발생: $e");
      rethrow;
    }
  }

  Future<bool> writeFeed({required CalorieResult param}) async {
    try {
      final response = await dio.post(
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

  Future<bool> writeComment({required Comment param}) async {
    try {
      final response = await dio.post(
        ApiConstants.writeComment,
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

  Future<bool> countUpLike({required String param}) async {
    try {
      final response = await dio.post(
        ApiConstants.countUpLike,
        data: {"feed_id": param},
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
