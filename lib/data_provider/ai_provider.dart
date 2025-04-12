import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:image_picker/image_picker.dart';

import '../core/logger.dart';

class AiProvider {
  final model = FirebaseVertexAI.instance.generativeModel(
    model: 'gemini-2.0-flash',
  );

  Future<String> getFoodAnswer({required String imageUrl}) async {
    String result = "";
    try {
      GenerateContentResponse response = await model.generateContent([
        Content("user", [
          TextPart(
            "이 사진 속 음식이 무엇인지 설명하고, "
            "이 음식은 제로칼로리라고 감성적으로 위로해줘."
            "'어머 이건 제로칼로리야!' 같은 문체로 재치 있게!",
          ),
        ]),
        Content("user", [FileData("image/jpeg", imageUrl)]),
      ]);
      // logger.d(response.candidates.first.content.parts.first);
      // logger.d(response.promptFeedback!.toString());
      // logger.d(response.usageMetadata);
      result = response.candidates.first.content.parts.first.toString();
    } catch (e) {
      logger.e(e);
    }
    return result;
  }
}
