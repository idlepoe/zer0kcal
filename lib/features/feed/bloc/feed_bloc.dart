import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zer0kcal/features/result/models/calorie_result.dart';
import 'package:zer0kcal/features/feed/bloc/feed_event.dart';
import 'package:zer0kcal/features/feed/bloc/feed_state.dart';
import 'package:zer0kcal/repositories/feed_repository.dart';

import '../../../core/logger.dart';
import '../models/feed.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final FeedRepository repository;
  List<Feed> _cache = [];

  FeedBloc(this.repository) : super(FeedInitial()) {
    on<FeedFetch>((event, emit) async {
      try {
        // 먼저 캐시에서 데이터를 확인
        final cachedFeeds = await repository.getFeedListFromCache();

        if (cachedFeeds.isNotEmpty) {
          // 캐시된 데이터가 있으면 먼저 표시
          _cache = cachedFeeds;
          emit(FeedCacheLoading(result: cachedFeeds, isRefreshing: true));
          logger.d('캐시된 피드 목록을 표시합니다. (${cachedFeeds.length}개 항목)');
        } else {
          // 캐시된 데이터가 없으면 로딩 상태 표시
          emit(FeedLoading());
        }

        // 백그라운드에서 최신 데이터 가져오기
        List<Feed> freshFeeds = await repository.getFeedList();
        logger.d('최신 피드 목록을 가져왔습니다. (${freshFeeds.length}개 항목)');

        // 캐시 업데이트
        _cache = freshFeeds;
        await repository.saveFeedListToCache(freshFeeds);

        // 최신 데이터로 화면 갱신
        emit(FeedFetchSuccess(result: freshFeeds, isFromCache: false));
      } catch (e) {
        // 에러 발생 시 캐시된 데이터가 있으면 그것을 사용
        if (_cache.isNotEmpty) {
          emit(FeedFetchSuccess(result: _cache, isFromCache: true));
          logger.w('네트워크 오류로 캐시된 데이터를 사용합니다: $e');
        } else {
          emit(FeedFailure(message: e.toString()));
        }
      }
    });

    on<FeedFetchFromCache>((event, emit) async {
      try {
        final cachedFeeds = await repository.getFeedListFromCache();
        if (cachedFeeds.isNotEmpty) {
          _cache = cachedFeeds;
          emit(FeedFetchSuccess(result: cachedFeeds, isFromCache: true));
          logger.d('캐시에서 피드 목록을 가져왔습니다. (${cachedFeeds.length}개 항목)');
        } else {
          emit(FeedLoading());
        }
      } catch (e) {
        emit(FeedFailure(message: e.toString()));
      }
    });

    on<FeedRefresh>((event, emit) async {
      try {
        // 캐시된 데이터가 있으면 먼저 표시
        if (_cache.isNotEmpty) {
          emit(FeedCacheLoading(result: _cache, isRefreshing: true));
        } else {
          emit(FeedLoading());
        }

        // 최신 데이터 가져오기
        List<Feed> freshFeeds = await repository.getFeedList();
        logger.d('피드 목록을 새로고침했습니다. (${freshFeeds.length}개 항목)');

        // 캐시 업데이트
        _cache = freshFeeds;
        await repository.saveFeedListToCache(freshFeeds);

        emit(FeedFetchSuccess(result: freshFeeds, isFromCache: false));
      } catch (e) {
        // 에러 발생 시 캐시된 데이터가 있으면 그것을 사용
        if (_cache.isNotEmpty) {
          emit(FeedFetchSuccess(result: _cache, isFromCache: true));
          logger.w('새로고침 중 오류로 캐시된 데이터를 사용합니다: $e');
        } else {
          emit(FeedFailure(message: e.toString()));
        }
      }
    });

    on<FeedPressed>((event, emit) async {});

    on<FeedUploadPressed>((event, emit) async {
      emit(FeedUploadRequested(result: _cache));
    });

    // 초기 로드 시 항상 백그라운드에서 최신 데이터 가져오기
    add(FeedFetch());
  }
}
