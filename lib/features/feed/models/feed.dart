import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed.freezed.dart';

part 'feed.g.dart';

String _stringFromJson(dynamic s) {
  return s.toString();
}

DateTime _fromTimestamp(dynamic value) => (value as Timestamp).toDate();
int _fromInt(dynamic value) => value is int?value:0;

@freezed
abstract class Feed with _$Feed {
  const factory Feed({
    @JsonKey(fromJson: _stringFromJson) required String id,
    @JsonKey(fromJson: _stringFromJson) required String url,
    @JsonKey(fromJson: _stringFromJson) required String result,
    @JsonKey(fromJson: _fromInt) required int likeCnt,
    @JsonKey(fromJson: _fromInt) required int commentCnt,
    @JsonKey(fromJson: _fromTimestamp) required DateTime createdAt,
  }) = _Feed;

  factory Feed.fromJson(Map<String, Object?> json) =>
      _$FeedFromJson(json);
}
