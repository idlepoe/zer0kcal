// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Comment {

@JsonKey(fromJson: _stringFromJson) String get id;@JsonKey(fromJson: _stringFromJson) String get feed_id;@JsonKey(fromJson: _stringFromJson) String get message;@JsonKey(fromJson: _fromTimestamp) DateTime get created_at;@JsonKey(fromJson: _fromTimestamp) DateTime get updated_at;
/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentCopyWith<Comment> get copyWith => _$CommentCopyWithImpl<Comment>(this as Comment, _$identity);

  /// Serializes this Comment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Comment&&(identical(other.id, id) || other.id == id)&&(identical(other.feed_id, feed_id) || other.feed_id == feed_id)&&(identical(other.message, message) || other.message == message)&&(identical(other.created_at, created_at) || other.created_at == created_at)&&(identical(other.updated_at, updated_at) || other.updated_at == updated_at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,feed_id,message,created_at,updated_at);

@override
String toString() {
  return 'Comment(id: $id, feed_id: $feed_id, message: $message, created_at: $created_at, updated_at: $updated_at)';
}


}

/// @nodoc
abstract mixin class $CommentCopyWith<$Res>  {
  factory $CommentCopyWith(Comment value, $Res Function(Comment) _then) = _$CommentCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _stringFromJson) String id,@JsonKey(fromJson: _stringFromJson) String feed_id,@JsonKey(fromJson: _stringFromJson) String message,@JsonKey(fromJson: _fromTimestamp) DateTime created_at,@JsonKey(fromJson: _fromTimestamp) DateTime updated_at
});




}
/// @nodoc
class _$CommentCopyWithImpl<$Res>
    implements $CommentCopyWith<$Res> {
  _$CommentCopyWithImpl(this._self, this._then);

  final Comment _self;
  final $Res Function(Comment) _then;

/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? feed_id = null,Object? message = null,Object? created_at = null,Object? updated_at = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,feed_id: null == feed_id ? _self.feed_id : feed_id // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,created_at: null == created_at ? _self.created_at : created_at // ignore: cast_nullable_to_non_nullable
as DateTime,updated_at: null == updated_at ? _self.updated_at : updated_at // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Comment implements Comment {
  const _Comment({@JsonKey(fromJson: _stringFromJson) required this.id, @JsonKey(fromJson: _stringFromJson) required this.feed_id, @JsonKey(fromJson: _stringFromJson) required this.message, @JsonKey(fromJson: _fromTimestamp) required this.created_at, @JsonKey(fromJson: _fromTimestamp) required this.updated_at});
  factory _Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

@override@JsonKey(fromJson: _stringFromJson) final  String id;
@override@JsonKey(fromJson: _stringFromJson) final  String feed_id;
@override@JsonKey(fromJson: _stringFromJson) final  String message;
@override@JsonKey(fromJson: _fromTimestamp) final  DateTime created_at;
@override@JsonKey(fromJson: _fromTimestamp) final  DateTime updated_at;

/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentCopyWith<_Comment> get copyWith => __$CommentCopyWithImpl<_Comment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Comment&&(identical(other.id, id) || other.id == id)&&(identical(other.feed_id, feed_id) || other.feed_id == feed_id)&&(identical(other.message, message) || other.message == message)&&(identical(other.created_at, created_at) || other.created_at == created_at)&&(identical(other.updated_at, updated_at) || other.updated_at == updated_at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,feed_id,message,created_at,updated_at);

@override
String toString() {
  return 'Comment(id: $id, feed_id: $feed_id, message: $message, created_at: $created_at, updated_at: $updated_at)';
}


}

/// @nodoc
abstract mixin class _$CommentCopyWith<$Res> implements $CommentCopyWith<$Res> {
  factory _$CommentCopyWith(_Comment value, $Res Function(_Comment) _then) = __$CommentCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _stringFromJson) String id,@JsonKey(fromJson: _stringFromJson) String feed_id,@JsonKey(fromJson: _stringFromJson) String message,@JsonKey(fromJson: _fromTimestamp) DateTime created_at,@JsonKey(fromJson: _fromTimestamp) DateTime updated_at
});




}
/// @nodoc
class __$CommentCopyWithImpl<$Res>
    implements _$CommentCopyWith<$Res> {
  __$CommentCopyWithImpl(this._self, this._then);

  final _Comment _self;
  final $Res Function(_Comment) _then;

/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? feed_id = null,Object? message = null,Object? created_at = null,Object? updated_at = null,}) {
  return _then(_Comment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,feed_id: null == feed_id ? _self.feed_id : feed_id // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,created_at: null == created_at ? _self.created_at : created_at // ignore: cast_nullable_to_non_nullable
as DateTime,updated_at: null == updated_at ? _self.updated_at : updated_at // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
