import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed.freezed.dart';

part 'feed.g.dart';

String _stringFromJson(dynamic s) {
  return s.toString();
}

@freezed
abstract class Feed with _$Feed {
  const factory Feed({
    @JsonKey(fromJson: _stringFromJson) required String id,
    @JsonKey(fromJson: _stringFromJson) required String url,
    @JsonKey(fromJson: _stringFromJson) required String result,
  }) = _Feed;

  factory Feed.fromJson(Map<String, Object?> json) =>
      _$FeedFromJson(json);
}
