import '../models/comment.dart';

abstract class FeedEvent {}

class FeedInitEvent extends FeedEvent {}

class FeedFetch extends FeedEvent {}

class FeedDetailFetch extends FeedEvent {
  final String feedID;
  FeedDetailFetch({required this.feedID});
}

class FeedLikePressed extends FeedEvent {
  final String feedID;
  FeedLikePressed({required this.feedID});
}

class FeedLikeLoadingStarted extends FeedEvent {}

class FeedLikeCompleted extends FeedEvent {
  final String feedID;
  FeedLikeCompleted({required this.feedID});
}

class FeedCommentPressed extends FeedEvent {
  final Comment comment;
  FeedCommentPressed({required this.comment});
}

class FeedCommentLoadingStarted extends FeedEvent {}

class FeedCommentLoadingCompleted extends FeedEvent {}

class FeedUploadPressed extends FeedEvent {}

class FeedPressed extends FeedEvent {}
