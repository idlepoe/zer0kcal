import 'package:image_picker/image_picker.dart';

import '../models/calorie_result.dart';

abstract class ResultState {}

class ResultInitial extends ResultState {}

class ResultShareLoading extends ResultState {
  final CalorieResult calorieResult;
  final XFile xFile;

  ResultShareLoading({required this.calorieResult, required this.xFile});
}

class ResultShareSuccess extends ResultState {}

class ResultUploadFeedLoading extends ResultState {}

class ResultSuccess extends ResultState {}

class ResultFailure extends ResultState {
  String message;

  ResultFailure({required this.message});
}
