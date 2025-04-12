import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zer0kcal/features/result/models/calorie_result.dart';
import 'package:zer0kcal/features/feed/bloc/feed_event.dart';
import 'package:zer0kcal/features/feed/bloc/feed_state.dart';
import 'package:zer0kcal/repositories/feed_repository.dart';

import '../../../core/logger.dart';
import '../models/feed.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final FeedRepository repository;

  FeedBloc(this.repository) : super(FeedInitial()) {
    on<FeedFetch>((event, emit) async {
      try {
        List<Feed> posts = await repository.fetchFeed();
        logger.d(posts);
        emit(FeedFetchSuccess(result: posts));
      } catch (e) {
        emit(FeedFailure(message: e.toString()));
      }
    });
    on<FeedPressed>((event, emit) async {});
    add(FeedFetch());
  }
}
