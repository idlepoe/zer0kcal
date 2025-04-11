import 'package:image_picker/image_picker.dart';
import 'package:zer0kcal/data_provider/firestorage_provider.dart';

import '../data_provider/ai_provider.dart';
import '../data_provider/firestore_provider.dart';
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
  Future<List<String>> fetchPosts() {
    // TODO: implement fetchPosts
    throw UnimplementedError();
  }

  @override
  Future<String> getFoodAnswer({required String imageUrl}) {
    return aiProvider.getFoodAnswer(imageUrl: imageUrl);
  }
}
