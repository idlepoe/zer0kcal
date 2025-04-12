// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Feed _$FeedFromJson(Map<String, dynamic> json) => _Feed(
  id: _stringFromJson(json['id']),
  url: _stringFromJson(json['url']),
  result: _stringFromJson(json['result']),
  likeCnt: _fromInt(json['likeCnt']),
  commentCnt: _fromInt(json['commentCnt']),
  createdAt: _fromTimestamp(json['createdAt']),
);

Map<String, dynamic> _$FeedToJson(_Feed instance) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'result': instance.result,
  'likeCnt': instance.likeCnt,
  'commentCnt': instance.commentCnt,
  'createdAt': instance.createdAt.toIso8601String(),
};
