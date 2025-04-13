import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed.freezed.dart';

part 'feed.g.dart';

String _stringFromJson(dynamic s) {
  return s is String ? s : "";
}

DateTime _fromTimestamp(dynamic value) {
  if (value == null) return DateTime.now();
  return value is Timestamp ? DateTime.now() : (value as Timestamp).toDate();
}

int _fromInt(dynamic value) => value is int ? value : 0;

@freezed
abstract class Feed with _$Feed {
  const factory Feed({
    @JsonKey(fromJson: _stringFromJson) required String id,
    @JsonKey(fromJson: _stringFromJson) required String url,
    @JsonKey(fromJson: _stringFromJson) required String message,
    @JsonKey(fromJson: _fromInt) required int cnt_like,
    @JsonKey(fromJson: _fromInt) required int cnt_comment,
    @JsonKey(fromJson: _fromTimestamp) required DateTime created_at,
  }) = _Feed;

  factory Feed.fromJson(Map<String, Object?> json) => _$FeedFromJson(json);
}
