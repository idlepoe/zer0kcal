import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../core/logger.dart';
import '../core/utils/app_utils.dart';

class FireStorageProvider {
  final FirebaseStorage _db = FirebaseStorage.instance;

  Future<String> uploadFileToStorage({required XFile xFile}) async {
    logger.d(xFile.toString());

    String result = "";
    try {
      Reference reference = _db.ref().child(
        "images/${AppUtils.getDateTimeKey()}_${xFile.name}",
      );
      await reference.putData(await xFile.readAsBytes());
      result = await reference.getDownloadURL();
      logger.d(result);
    } catch (e) {
      logger.e(e);
      logger.e(e.toString());
      return "";
    }

    return result;
  }
}
