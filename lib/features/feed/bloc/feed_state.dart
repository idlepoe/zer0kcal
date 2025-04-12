import 'package:zer0kcal/features/result/models/calorie_result.dart';

import '../models/feed.dart';

abstract class FeedState {}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

class FeedFetchSuccess extends FeedState {
  List<Feed> result;

  FeedFetchSuccess({required this.result});
}

class FeedFailure extends FeedState {
  String message;

  FeedFailure({required this.message});
}
