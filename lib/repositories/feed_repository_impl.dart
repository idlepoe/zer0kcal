import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zer0kcal/data_provider/firestorage_provider.dart';
import 'package:zer0kcal/features/feed/models/comment.dart';
import 'package:zer0kcal/features/result/models/calorie_result.dart';

import '../core/dio_interceptor.dart';
import '../core/logger.dart';
import '../data_provider/ai_provider.dart';
import '../data_provider/firestore_provider.dart';
import '../features/feed/models/feed.dart';
import 'feed_repository.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FirestoreProvider fireProvider;
  final AiProvider aiProvider;
  static const String _cacheKey = 'feed_list_cache';
  static const String _cacheTimestampKey = 'feed_list_cache_timestamp';

  FeedRepositoryImpl(this.fireProvider, this.aiProvider);

  @override
  Future<String> uploadPicture({required XFile xFile}) async {
    return FireStorageProvider().uploadFileToStorage(xFile: xFile);
  }

  @override
  Future<String> getFoodAnswer({required String imageUrl}) {
    return aiProvider.getFoodAnswer(imageUrl: imageUrl);
  }

  @override
  Future<bool> writeFeed({required CalorieResult param}) {
    return fireProvider.writeFeed(param: param);
  }

  @override
  Future<List<Feed>> getFeedList() async {
    List<Map<String, dynamic>> result = await fireProvider.getFeedList();
    List<Feed> resultList = [];
    for (Map<String, dynamic> row in result) {
      resultList.add(Feed.fromJson(row));
    }
    return resultList;
  }

  @override
  Future<Feed> getFeedDetail({required String feedID}) async {
    logger.d("getFeedDetail");
    Map<String, dynamic> result = await fireProvider.getFeedDetail(
      feedID: feedID,
    );
    return Feed.fromJson(result);
  }

  @override
  Future<bool> countUpLike({required String feedID}) {
    return fireProvider.countUpLike(param: feedID);
  }

  @override
  Future<bool> writeComment({required Comment param}) {
    return fireProvider.writeComment(param: param);
  }

  // 캐시 관련 메서드들
  @override
  Future<List<Feed>> getFeedListFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString(_cacheKey);

      if (cachedData != null) {
        final List<dynamic> jsonList = jsonDecode(cachedData);
        final feeds = jsonList.map((json) => Feed.fromJson(json)).toList();
        logger.d('캐시에서 피드 목록을 가져왔습니다. (${feeds.length}개 항목)');
        return feeds;
      }
      return [];
    } catch (e) {
      logger.e('캐시에서 피드 목록을 가져오는 중 오류 발생: $e');
      return [];
    }
  }

  @override
  Future<void> saveFeedListToCache(List<Feed> feeds) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = feeds.map((feed) => feed.toJson()).toList();
      final jsonString = jsonEncode(jsonList);

      await prefs.setString(_cacheKey, jsonString);
      await prefs.setInt(
        _cacheTimestampKey,
        DateTime.now().millisecondsSinceEpoch,
      );

      logger.d('피드 목록이 캐시에 저장되었습니다. (${feeds.length}개 항목)');
    } catch (e) {
      logger.e('피드 목록을 캐시에 저장하는 중 오류 발생: $e');
    }
  }

  @override
  Future<void> clearFeedCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cacheKey);
      await prefs.remove(_cacheTimestampKey);
      logger.d('피드 캐시가 삭제되었습니다.');
    } catch (e) {
      logger.e('피드 캐시를 삭제하는 중 오류 발생: $e');
    }
  }

  @override
  Future<bool> hasCachedFeedList() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString(_cacheKey);
      return cachedData != null;
    } catch (e) {
      logger.e('캐시 상태를 확인하는 중 오류 발생: $e');
      return false;
    }
  }
}
