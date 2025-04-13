// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calorie_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CalorieResult {

@JsonKey(fromJson: _stringFromJson) String get url;@JsonKey(fromJson: _stringFromJson) String get message;
/// Create a copy of CalorieResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalorieResultCopyWith<CalorieResult> get copyWith => _$CalorieResultCopyWithImpl<CalorieResult>(this as CalorieResult, _$identity);

  /// Serializes this CalorieResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalorieResult&&(identical(other.url, url) || other.url == url)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,message);

@override
String toString() {
  return 'CalorieResult(url: $url, message: $message)';
}


}

/// @nodoc
abstract mixin class $CalorieResultCopyWith<$Res>  {
  factory $CalorieResultCopyWith(CalorieResult value, $Res Function(CalorieResult) _then) = _$CalorieResultCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _stringFromJson) String url,@JsonKey(fromJson: _stringFromJson) String message
});




}
/// @nodoc
class _$CalorieResultCopyWithImpl<$Res>
    implements $CalorieResultCopyWith<$Res> {
  _$CalorieResultCopyWithImpl(this._self, this._then);

  final CalorieResult _self;
  final $Res Function(CalorieResult) _then;

/// Create a copy of CalorieResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? message = null,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CalorieResult implements CalorieResult {
  const _CalorieResult({@JsonKey(fromJson: _stringFromJson) required this.url, @JsonKey(fromJson: _stringFromJson) required this.message});
  factory _CalorieResult.fromJson(Map<String, dynamic> json) => _$CalorieResultFromJson(json);

@override@JsonKey(fromJson: _stringFromJson) final  String url;
@override@JsonKey(fromJson: _stringFromJson) final  String message;

/// Create a copy of CalorieResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalorieResultCopyWith<_CalorieResult> get copyWith => __$CalorieResultCopyWithImpl<_CalorieResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalorieResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalorieResult&&(identical(other.url, url) || other.url == url)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,message);

@override
String toString() {
  return 'CalorieResult(url: $url, message: $message)';
}


}

/// @nodoc
abstract mixin class _$CalorieResultCopyWith<$Res> implements $CalorieResultCopyWith<$Res> {
  factory _$CalorieResultCopyWith(_CalorieResult value, $Res Function(_CalorieResult) _then) = __$CalorieResultCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _stringFromJson) String url,@JsonKey(fromJson: _stringFromJson) String message
});




}
/// @nodoc
class __$CalorieResultCopyWithImpl<$Res>
    implements _$CalorieResultCopyWith<$Res> {
  __$CalorieResultCopyWithImpl(this._self, this._then);

  final _CalorieResult _self;
  final $Res Function(_CalorieResult) _then;

/// Create a copy of CalorieResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? message = null,}) {
  return _then(_CalorieResult(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
