import 'package:image_picker/image_picker.dart';
import 'package:zer0kcal/data_provider/firestorage_provider.dart';

import '../data_provider/firestore_provider.dart';
import 'feed_repository.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FirestoreProvider provider;

  FeedRepositoryImpl(this.provider);

  @override
  Future<String> uploadPicture({required XFile xFile}) async {
    return FireStorageProvider().uploadFileToStorage( xFile: xFile);
  }

  @override
  Future<List<String>> fetchPosts() {
    // TODO: implement fetchPosts
    throw UnimplementedError();
  }
}
