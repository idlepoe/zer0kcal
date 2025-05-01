// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Comment _$CommentFromJson(Map<String, dynamic> json) => _Comment(
  id: _toString(json['id']),
  feed_id: _toString(json['feed_id']),
  message: _toString(json['message']),
  created_at: _fromTimestamp(json['created_at']),
  updated_at: _fromTimestamp(json['updated_at']),
);

Map<String, dynamic> _$CommentToJson(_Comment instance) => <String, dynamic>{
  'id': instance.id,
  'feed_id': instance.feed_id,
  'message': instance.message,
  'created_at': instance.created_at.toIso8601String(),
  'updated_at': instance.updated_at.toIso8601String(),
};
