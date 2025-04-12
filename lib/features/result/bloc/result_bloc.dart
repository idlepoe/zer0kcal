import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zer0kcal/features/result/bloc/result_event.dart';
import 'package:zer0kcal/features/result/bloc/result_state.dart';
import 'package:zer0kcal/repositories/feed_repository.dart';

import '../../../core/logger.dart';
import '../../../core/utils/app_utils.dart';
import '../models/calorie_result.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  final FeedRepository repository;

  ResultBloc(this.repository) : super(ResultInitial()) {
    on<ResultSharePressed>((event, emit) async {
      try {
        emit(
          ResultShareLoading(
            calorieResult: event.calorieResult,
            xFile: event.xFile,
          ),
        );
      } catch (e) {
        List<String> msgList = [
          "앗! 귤이가 전송 버튼을 놓쳤어요... 다시 시도해볼까요? 🍊",
          "공유하러 갔는데… 길을 잃었나 봐요 😢",
          "잠깐 통신 오류! 다시 공유하면 분명 성공할 거예요!",
        ];
        emit(ResultFailure(message: msgList[Random().nextInt(msgList.length)]));
      }
      emit(ResultShareSuccess());
    });
    on<ResultUploadFeedPressed>((event, emit) async {
      try {
        emit(ResultUploadFeedLoading());
        CalorieResult calorieResult = await event.calorieResult;
        repository.uploadPost(calorieResult: calorieResult);
      } catch (e) {
        List<String> msgList = [
          "귤이가 너무 감동해서 잠깐 멈췄어요. 다시 한 번만 올려봐요!",
          "앗, 피드로 날아가던 중에 바람을 타지 못했어요 🍃",
          "잠시 네트워크가 흐릿해졌나 봐요. 다시 시도해볼까요?",
        ];
        emit(ResultFailure(message: msgList[Random().nextInt(msgList.length)]));
        return;
      }
      emit(ResultSuccess());
    });
    on<ResultShareAppPressed>((event, emit) async {});
  }
}
