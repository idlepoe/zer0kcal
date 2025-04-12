import 'package:zer0kcal/features/result/models/calorie_result.dart';

abstract class UploadState {}

class UploadInitial extends UploadState {}

class UploadLoading extends UploadState {}

class UploadAiLoading extends UploadState {}

class UploadSuccess extends UploadState {
  CalorieResult result;

  UploadSuccess({required this.result});
}

class UploadFailure extends UploadState {
  String message;

  UploadFailure({required this.message});
}
