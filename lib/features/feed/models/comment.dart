import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';

part 'comment.g.dart';

String _stringFromJson(dynamic s) {
  return s is String ? s : "";
}

DateTime _fromTimestamp(dynamic value) {
  if (value == null) return DateTime.now();
  if (value is Map<String, dynamic> && value.containsKey('_seconds')) {
    return DateTime.fromMillisecondsSinceEpoch(value['_seconds'] * 1000);
  }
  return value is Timestamp ? (value as Timestamp).toDate() : DateTime.now();
}

int _fromInt(dynamic value) => value is int ? value : 0;

@freezed
abstract class Comment with _$Comment {
  const factory Comment({
    @JsonKey(fromJson: _stringFromJson) required String id,
    @JsonKey(fromJson: _stringFromJson) required String feed_id,
    @JsonKey(fromJson: _stringFromJson) required String message,
    @JsonKey(fromJson: _fromTimestamp) required DateTime created_at,
    @JsonKey(fromJson: _fromTimestamp) required DateTime updated_at,
  }) = _Comment;

  factory Comment.fromJson(Map<String, Object?> json) => _$CommentFromJson(json);
}
