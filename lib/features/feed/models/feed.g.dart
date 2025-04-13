// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Feed _$FeedFromJson(Map<String, dynamic> json) => _Feed(
  id: _stringFromJson(json['id']),
  url: _stringFromJson(json['url']),
  message: _stringFromJson(json['message']),
  cnt_like: _fromInt(json['cnt_like']),
  cnt_comment: _fromInt(json['cnt_comment']),
  created_at: _fromTimestamp(json['created_at']),
);

Map<String, dynamic> _$FeedToJson(_Feed instance) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'message': instance.message,
  'cnt_like': instance.cnt_like,
  'cnt_comment': instance.cnt_comment,
  'created_at': instance.created_at.toIso8601String(),
};
