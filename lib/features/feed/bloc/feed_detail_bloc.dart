import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zer0kcal/features/result/models/calorie_result.dart';
import 'package:zer0kcal/features/feed/bloc/feed_event.dart';
import 'package:zer0kcal/features/feed/bloc/feed_state.dart';
import 'package:zer0kcal/repositories/feed_repository.dart';

import '../../../core/logger.dart';
import '../models/feed.dart';

class FeedDetailBloc extends Bloc<FeedEvent, FeedState> {
  final FeedRepository repository;
  Feed _cache = Feed.fromJson({});

  FeedDetailBloc(this.repository) : super(FeedInitial()) {
    on<FeedDetailFetch>((event, emit) async {
      try {
        Feed posts = await repository.getFeedDetail();
        _cache = posts;
        emit(FeedDetailFetchSuccess(result: posts));
      } catch (e) {
        emit(FeedFailure(message: e.toString()));
      }
    });
  }
}
