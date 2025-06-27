import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/feed.dart';

part 'feed_state.freezed.dart';

abstract class FeedState {}

abstract class HasFeedList {
  List<Feed> get result;
}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

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

  FeedFetchSuccess({required this.result});
}

class FeedDetailFetchSuccess extends FeedState {
  Feed result;

  FeedDetailFetchSuccess({required this.result});
}

class FeedFailure extends FeedState {
  String message;

  FeedFailure({required this.message});
}
