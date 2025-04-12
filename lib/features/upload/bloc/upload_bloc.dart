import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zer0kcal/features/result/models/calorie_result.dart';
import 'package:zer0kcal/features/upload/bloc/upload_event.dart';
import 'package:zer0kcal/features/upload/bloc/upload_state.dart';
import 'package:zer0kcal/repositories/feed_repository.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final FeedRepository repository;

  UploadBloc(this.repository) : super(UploadInitial()) {
    on<UploadPressed>((event, emit) async {
      emit(UploadLoading());
      String url = await repository.uploadPicture(xFile: event.xFile);
      if (url.isNotEmpty) {
        emit(UploadAiLoading());
        String answer = await repository.getFoodAnswer(imageUrl: url);
        if (answer.isEmpty) {
          emit(UploadFailure(message: "앗! 사진이 미끄러졌어요. 다시 한번 부탁해요."));
        } else {
          emit(UploadSuccess(result: CalorieResult(url: url, result: answer)));
        }
      } else {
        emit(UploadFailure(message: "앗! 사진이 미끄러졌어요. 다시 한번 부탁해요."));
      }
    });
  }
}
