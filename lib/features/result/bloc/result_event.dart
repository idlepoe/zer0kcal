import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';

import '../models/calorie_result.dart';

abstract class ResultEvent {}

class ResultInitEvent extends ResultEvent {}

class ResultSharePressed extends ResultEvent {
  final CalorieResult calorieResult;
  final XFile xFile;
  ResultSharePressed({required this.xFile, required this.calorieResult});
}

class ResultUploadFeedPressed extends ResultEvent {
  final CalorieResult calorieResult;

  ResultUploadFeedPressed({required this.calorieResult});
}

class ResultShareAppPressed extends ResultEvent {}
