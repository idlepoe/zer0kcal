import '../models/feed.dart';

abstract class FeedState {}

abstract class HasFeedList {
  List<Feed> get result;
}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

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

class FeedFailure extends FeedState {
  String message;

  FeedFailure({required this.message});
}
