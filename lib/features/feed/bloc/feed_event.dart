import '../models/comment.dart';
import '../models/feed.dart';

abstract class FeedEvent {}

class FeedInitEvent extends FeedEvent {}

class FeedFetch extends FeedEvent {}

class FeedFetchFromCache extends FeedEvent {}

class FeedRefresh extends FeedEvent {}

class FeedDetailFetch extends FeedEvent {
  final String feedID;
  FeedDetailFetch({required this.feedID});
}

class FeedDetailFetchWithInitial extends FeedEvent {
  final String feedID;
  final Feed initialData;
  FeedDetailFetchWithInitial({required this.feedID, required this.initialData});
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
