import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/feed.dart';

part 'feed_state.freezed.dart';

abstract class FeedState {}

abstract class HasFeedList {
  List<Feed> get result;
}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

class FeedCacheLoading extends FeedState implements HasFeedList {
  @override
  List<Feed> result;
  bool isRefreshing;

  FeedCacheLoading({required this.result, this.isRefreshing = false});
}

class FeedLikeLoading extends FeedState {
  Feed result;
  FeedLikeLoading({required this.result});
}

class FeedCommentLoading extends FeedState {
  Feed result;
  FeedCommentLoading({required this.result});
}

class FeedLikeAnimating extends FeedState {
  Feed result;
  String feedID;
  FeedLikeAnimating({required this.result, required this.feedID});
}

class FeedUploadRequested extends FeedState implements HasFeedList {
  @override
  List<Feed> result;

  FeedUploadRequested({required this.result});
}

class FeedFetchSuccess extends FeedState implements HasFeedList {
  @override
  List<Feed> result;
  bool isFromCache;

  FeedFetchSuccess({required this.result, this.isFromCache = false});
}

class FeedDetailFetchSuccess extends FeedState {
  Feed result;

  FeedDetailFetchSuccess({required this.result});
}

class FeedDetailWithInitial extends FeedState {
  Feed result;
  bool isRefreshing;

  FeedDetailWithInitial({required this.result, this.isRefreshing = false});
}

class FeedFailure extends FeedState {
  String message;

  FeedFailure({required this.message});
}
