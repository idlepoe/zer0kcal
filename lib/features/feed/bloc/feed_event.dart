
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

class FeedCommentPressed extends FeedEvent {
  final Comment comment;
  FeedCommentPressed({required this.comment});
}


class FeedUploadPressed extends FeedEvent {}

class FeedPressed extends FeedEvent {}
