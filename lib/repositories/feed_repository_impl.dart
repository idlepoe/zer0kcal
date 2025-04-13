import 'package:image_picker/image_picker.dart';
import 'package:zer0kcal/data_provider/firestorage_provider.dart';
import 'package:zer0kcal/features/feed/models/comment.dart';
import 'package:zer0kcal/features/result/models/calorie_result.dart';

import '../core/dio_interceptor.dart';
import '../data_provider/ai_provider.dart';
import '../data_provider/firestore_provider.dart';
import '../features/feed/models/feed.dart';
import 'feed_repository.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FirestoreProvider fireProvider;
  final AiProvider aiProvider;

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
      logger.w(row);
      resultList.add(Feed.fromJson(row));

    }
    return resultList;
  }

  @override
  Future<Feed> getFeedDetail({required String feedID}) async {
    logger.d("getFeedDetail");
    Map<String, dynamic> result = await fireProvider.getFeedDetail(feedID: feedID);
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
}
