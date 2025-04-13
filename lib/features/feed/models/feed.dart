import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/dio_interceptor.dart';
import 'comment.dart';

part 'feed.freezed.dart';

part 'feed.g.dart';

String _stringFromJson(dynamic s) {
  return s is String ? s : "";
}

DateTime _fromTimestamp(dynamic value) {
  if (value == null) return DateTime.now();
  return value is Timestamp ? (value as Timestamp).toDate() : DateTime.now();
}

int _fromInt(dynamic value) => value is int ? value : 0;

List<Comment> _toListComment(dynamic value) {
  List<Comment> result = [];
  if(value==null) return result;
  for (dynamic row in value) {
    result.add(Comment.fromJson(row));
  }
  return result;
}

@freezed
abstract class Feed with _$Feed {
  const factory Feed({
    @JsonKey(fromJson: _stringFromJson) required String id,
    @JsonKey(fromJson: _stringFromJson) required String url,
    @JsonKey(fromJson: _stringFromJson) required String message,
    @JsonKey(fromJson: _fromInt) required int cnt_like,
    @JsonKey(fromJson: _fromInt) required int cnt_comment,
    @JsonKey(fromJson: _toListComment) required List<Comment> comments,
    @JsonKey(fromJson: _fromTimestamp) required DateTime created_at,
    @JsonKey(fromJson: _fromTimestamp) required DateTime updated_at,
  }) = _Feed;

  factory Feed.fromJson(Map<String, Object?> json) => _$FeedFromJson(json);
}
