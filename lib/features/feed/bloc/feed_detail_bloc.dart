import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zer0kcal/features/result/models/calorie_result.dart';
import 'package:zer0kcal/features/feed/bloc/feed_event.dart';
import 'package:zer0kcal/features/feed/bloc/feed_state.dart';
import 'package:zer0kcal/repositories/feed_repository.dart';

import '../../../core/logger.dart';
import '../models/feed.dart';

class FeedDetailBloc extends Bloc<FeedEvent, FeedState> {
  final FeedRepository repository;
  Feed _cache = Feed.fromJson({});
  final String _likeKey = 'liked_feeds';

  FeedDetailBloc(this.repository) : super(FeedInitial()) {
    on<FeedDetailFetch>((event, emit) async {
      try {
        emit(FeedLoading());
        Feed posts = await repository.getFeedDetail(feedID: event.feedID);
        _cache = posts;
        emit(FeedDetailFetchSuccess(result: posts));
      } catch (e) {
        emit(FeedFailure(message: e.toString()));
      }
    });

    on<FeedLikeLoadingStarted>((event, emit) async {
      emit(FeedLikeLoading(result: _cache));
    });

    on<FeedLikePressed>((event, emit) async {
      try {
        // 좋아요 로딩 상태 시작
        emit(FeedLikeLoading(result: _cache));

        // 중복 좋아요 체크
        final prefs = await SharedPreferences.getInstance();
        final likedFeeds = prefs.getStringList(_likeKey) ?? [];
        if (likedFeeds.contains(event.feedID)) {
          emit(FeedDetailFetchSuccess(result: _cache));
          return;
        }

        // 좋아요 처리
        bool result = await repository.countUpLike(feedID: event.feedID);
        if (result) {
          // SharedPreferences에 저장
          likedFeeds.add(event.feedID);
          await prefs.setStringList(_likeKey, likedFeeds);

          // 피드 새로고침
          Feed posts = await repository.getFeedDetail(feedID: event.feedID);
          _cache = posts;

          // 애니메이션 상태로 전환
          emit(FeedLikeAnimating(result: posts, feedID: event.feedID));
        } else {
          emit(FeedFailure(message: "제로칼로리 서버가 잠깐 간식 먹으러 갔나봐요 🍩"));
        }
      } catch (e) {
        emit(FeedFailure(message: e.toString()));
      }
    });

    on<FeedLikeCompleted>((event, emit) async {
      emit(FeedDetailFetchSuccess(result: _cache));
    });

    on<FeedCommentLoadingStarted>((event, emit) async {
      emit(FeedCommentLoading(result: _cache));
    });

    on<FeedCommentPressed>((event, emit) async {
      try {
        // 댓글 로딩 상태 시작
        emit(FeedCommentLoading(result: _cache));

        bool result = await repository.writeComment(param: event.comment);
        if (result) {
          Feed posts = await repository.getFeedDetail(
            feedID: event.comment.feed_id,
          );
          _cache = posts;
          emit(FeedDetailFetchSuccess(result: posts));
        } else {
          emit(FeedFailure(message: "제로칼로리 서버가 잠깐 간식 먹으러 갔나봐요 🍩"));
        }
      } catch (e) {
        emit(FeedFailure(message: e.toString()));
      }
    });

    on<FeedCommentLoadingCompleted>((event, emit) async {
      emit(FeedDetailFetchSuccess(result: _cache));
    });
  }

  Future<bool> checkIfAlreadyLiked(String feedId) async {
    final prefs = await SharedPreferences.getInstance();
    final likedFeeds = prefs.getStringList(_likeKey) ?? [];
    return likedFeeds.contains(feedId);
  }
}
