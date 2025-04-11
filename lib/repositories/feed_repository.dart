import 'package:image_picker/image_picker.dart';

abstract class FeedRepository {
  Future<String> getFoodAnswer({required String imageUrl});
  Future<String> uploadPicture({required XFile xFile});
  Future<List<String>> fetchPosts();
}
