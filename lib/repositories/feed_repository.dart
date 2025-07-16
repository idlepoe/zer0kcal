import 'package:image_picker/image_picker.dart';

import '../features/feed/models/comment.dart';
import '../features/feed/models/feed.dart';
import '../features/result/models/calorie_result.dart';

abstract class FeedRepository {
  Future<String> uploadPicture({required XFile xFile});

  Future<String> getFoodAnswer({required String imageUrl});

  Future<List<Feed>> getFeedList();

  Future<bool> writeFeed({required CalorieResult param});

  Future<Feed> getFeedDetail({required String feedID});

  Future<bool> writeComment({required Comment param});

  Future<bool> countUpLike({required String feedID});

  // 캐시 관련 메서드들
  Future<List<Feed>> getFeedListFromCache();
  Future<void> saveFeedListToCache(List<Feed> feeds);
  Future<void> clearFeedCache();
  Future<bool> hasCachedFeedList();
}
