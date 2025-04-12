import 'package:image_picker/image_picker.dart';

import '../features/result/models/calorie_result.dart';

abstract class FeedRepository {
  Future<String> uploadPicture({required XFile xFile});
  Future<String> getFoodAnswer({required String imageUrl});
  Future<List<String>> fetchPosts();
  Future<bool> uploadPost({required CalorieResult calorieResult});
}
