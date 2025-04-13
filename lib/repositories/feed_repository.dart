import 'package:image_picker/image_picker.dart';

import '../features/feed/models/feed.dart';
import '../features/result/models/calorie_result.dart';

abstract class FeedRepository {
  Future<String> uploadPicture({required XFile xFile});

  Future<String> getFoodAnswer({required String imageUrl});

  Future<List<Feed>> getFeedList();

  Future<bool> writeFeed({required CalorieResult param});
}
