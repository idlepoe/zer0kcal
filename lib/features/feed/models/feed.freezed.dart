// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Feed {

@JsonKey(fromJson: _stringFromJson) String get id;@JsonKey(fromJson: _stringFromJson) String get url;@JsonKey(fromJson: _stringFromJson) String get result;@JsonKey(fromJson: _fromInt) int get likeCnt;@JsonKey(fromJson: _fromInt) int get commentCnt;@JsonKey(fromJson: _fromTimestamp) DateTime get createdAt;
/// Create a copy of Feed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedCopyWith<Feed> get copyWith => _$FeedCopyWithImpl<Feed>(this as Feed, _$identity);

  /// Serializes this Feed to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Feed&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.result, result) || other.result == result)&&(identical(other.likeCnt, likeCnt) || other.likeCnt == likeCnt)&&(identical(other.commentCnt, commentCnt) || other.commentCnt == commentCnt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,url,result,likeCnt,commentCnt,createdAt);

@override
String toString() {
  return 'Feed(id: $id, url: $url, result: $result, likeCnt: $likeCnt, commentCnt: $commentCnt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $FeedCopyWith<$Res>  {
  factory $FeedCopyWith(Feed value, $Res Function(Feed) _then) = _$FeedCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _stringFromJson) String id,@JsonKey(fromJson: _stringFromJson) String url,@JsonKey(fromJson: _stringFromJson) String result,@JsonKey(fromJson: _fromInt) int likeCnt,@JsonKey(fromJson: _fromInt) int commentCnt,@JsonKey(fromJson: _fromTimestamp) DateTime createdAt
});




}
/// @nodoc
class _$FeedCopyWithImpl<$Res>
    implements $FeedCopyWith<$Res> {
  _$FeedCopyWithImpl(this._self, this._then);

  final Feed _self;
  final $Res Function(Feed) _then;

/// Create a copy of Feed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? url = null,Object? result = null,Object? likeCnt = null,Object? commentCnt = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as String,likeCnt: null == likeCnt ? _self.likeCnt : likeCnt // ignore: cast_nullable_to_non_nullable
as int,commentCnt: null == commentCnt ? _self.commentCnt : commentCnt // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Feed implements Feed {
  const _Feed({@JsonKey(fromJson: _stringFromJson) required this.id, @JsonKey(fromJson: _stringFromJson) required this.url, @JsonKey(fromJson: _stringFromJson) required this.result, @JsonKey(fromJson: _fromInt) required this.likeCnt, @JsonKey(fromJson: _fromInt) required this.commentCnt, @JsonKey(fromJson: _fromTimestamp) required this.createdAt});
  factory _Feed.fromJson(Map<String, dynamic> json) => _$FeedFromJson(json);

@override@JsonKey(fromJson: _stringFromJson) final  String id;
@override@JsonKey(fromJson: _stringFromJson) final  String url;
@override@JsonKey(fromJson: _stringFromJson) final  String result;
@override@JsonKey(fromJson: _fromInt) final  int likeCnt;
@override@JsonKey(fromJson: _fromInt) final  int commentCnt;
@override@JsonKey(fromJson: _fromTimestamp) final  DateTime createdAt;

/// Create a copy of Feed
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedCopyWith<_Feed> get copyWith => __$FeedCopyWithImpl<_Feed>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Feed&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.result, result) || other.result == result)&&(identical(other.likeCnt, likeCnt) || other.likeCnt == likeCnt)&&(identical(other.commentCnt, commentCnt) || other.commentCnt == commentCnt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,url,result,likeCnt,commentCnt,createdAt);

@override
String toString() {
  return 'Feed(id: $id, url: $url, result: $result, likeCnt: $likeCnt, commentCnt: $commentCnt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$FeedCopyWith<$Res> implements $FeedCopyWith<$Res> {
  factory _$FeedCopyWith(_Feed value, $Res Function(_Feed) _then) = __$FeedCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _stringFromJson) String id,@JsonKey(fromJson: _stringFromJson) String url,@JsonKey(fromJson: _stringFromJson) String result,@JsonKey(fromJson: _fromInt) int likeCnt,@JsonKey(fromJson: _fromInt) int commentCnt,@JsonKey(fromJson: _fromTimestamp) DateTime createdAt
});




}
/// @nodoc
class __$FeedCopyWithImpl<$Res>
    implements _$FeedCopyWith<$Res> {
  __$FeedCopyWithImpl(this._self, this._then);

  final _Feed _self;
  final $Res Function(_Feed) _then;

/// Create a copy of Feed
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? url = null,Object? result = null,Object? likeCnt = null,Object? commentCnt = null,Object? createdAt = null,}) {
  return _then(_Feed(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as String,likeCnt: null == likeCnt ? _self.likeCnt : likeCnt // ignore: cast_nullable_to_non_nullable
as int,commentCnt: null == commentCnt ? _self.commentCnt : commentCnt // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
