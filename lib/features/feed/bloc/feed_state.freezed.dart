// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeedState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedState()';
}


}

/// @nodoc
class $FeedStateCopyWith<$Res>  {
$FeedStateCopyWith(FeedState _, $Res Function(FeedState) __);
}


/// @nodoc


class _Initial implements FeedState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedState.initial()';
}


}




/// @nodoc


class _Loading implements FeedState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedState.loading()';
}


}




/// @nodoc


class _UploadRequested implements FeedState {
  const _UploadRequested({required final  List<Feed> result}): _result = result;
  

 final  List<Feed> _result;
 List<Feed> get result {
  if (_result is EqualUnmodifiableListView) return _result;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_result);
}


/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UploadRequestedCopyWith<_UploadRequested> get copyWith => __$UploadRequestedCopyWithImpl<_UploadRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UploadRequested&&const DeepCollectionEquality().equals(other._result, _result));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_result));

@override
String toString() {
  return 'FeedState.uploadRequested(result: $result)';
}


}

/// @nodoc
abstract mixin class _$UploadRequestedCopyWith<$Res> implements $FeedStateCopyWith<$Res> {
  factory _$UploadRequestedCopyWith(_UploadRequested value, $Res Function(_UploadRequested) _then) = __$UploadRequestedCopyWithImpl;
@useResult
$Res call({
 List<Feed> result
});




}
/// @nodoc
class __$UploadRequestedCopyWithImpl<$Res>
    implements _$UploadRequestedCopyWith<$Res> {
  __$UploadRequestedCopyWithImpl(this._self, this._then);

  final _UploadRequested _self;
  final $Res Function(_UploadRequested) _then;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = null,}) {
  return _then(_UploadRequested(
result: null == result ? _self._result : result // ignore: cast_nullable_to_non_nullable
as List<Feed>,
  ));
}


}

/// @nodoc


class _FetchSuccess implements FeedState {
  const _FetchSuccess({required final  List<Feed> result}): _result = result;
  

 final  List<Feed> _result;
 List<Feed> get result {
  if (_result is EqualUnmodifiableListView) return _result;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_result);
}


/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchSuccessCopyWith<_FetchSuccess> get copyWith => __$FetchSuccessCopyWithImpl<_FetchSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchSuccess&&const DeepCollectionEquality().equals(other._result, _result));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_result));

@override
String toString() {
  return 'FeedState.fetchSuccess(result: $result)';
}


}

/// @nodoc
abstract mixin class _$FetchSuccessCopyWith<$Res> implements $FeedStateCopyWith<$Res> {
  factory _$FetchSuccessCopyWith(_FetchSuccess value, $Res Function(_FetchSuccess) _then) = __$FetchSuccessCopyWithImpl;
@useResult
$Res call({
 List<Feed> result
});




}
/// @nodoc
class __$FetchSuccessCopyWithImpl<$Res>
    implements _$FetchSuccessCopyWith<$Res> {
  __$FetchSuccessCopyWithImpl(this._self, this._then);

  final _FetchSuccess _self;
  final $Res Function(_FetchSuccess) _then;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = null,}) {
  return _then(_FetchSuccess(
result: null == result ? _self._result : result // ignore: cast_nullable_to_non_nullable
as List<Feed>,
  ));
}


}

/// @nodoc


class _DetailFetchSuccess implements FeedState {
  const _DetailFetchSuccess({required this.result});
  

 final  Feed result;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DetailFetchSuccessCopyWith<_DetailFetchSuccess> get copyWith => __$DetailFetchSuccessCopyWithImpl<_DetailFetchSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DetailFetchSuccess&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,result);

@override
String toString() {
  return 'FeedState.detailFetchSuccess(result: $result)';
}


}

/// @nodoc
abstract mixin class _$DetailFetchSuccessCopyWith<$Res> implements $FeedStateCopyWith<$Res> {
  factory _$DetailFetchSuccessCopyWith(_DetailFetchSuccess value, $Res Function(_DetailFetchSuccess) _then) = __$DetailFetchSuccessCopyWithImpl;
@useResult
$Res call({
 Feed result
});


$FeedCopyWith<$Res> get result;

}
/// @nodoc
class __$DetailFetchSuccessCopyWithImpl<$Res>
    implements _$DetailFetchSuccessCopyWith<$Res> {
  __$DetailFetchSuccessCopyWithImpl(this._self, this._then);

  final _DetailFetchSuccess _self;
  final $Res Function(_DetailFetchSuccess) _then;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = null,}) {
  return _then(_DetailFetchSuccess(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as Feed,
  ));
}

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedCopyWith<$Res> get result {
  
  return $FeedCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

/// @nodoc


class _Failure implements FeedState {
  const _Failure({required this.message});
  

 final  String message;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'FeedState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $FeedStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Failure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
