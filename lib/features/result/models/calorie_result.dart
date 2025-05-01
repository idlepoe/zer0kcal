import 'package:freezed_annotation/freezed_annotation.dart';

part 'calorie_result.freezed.dart';

part 'calorie_result.g.dart';

String _toString(dynamic s) {
  return s.toString();
}

@freezed
abstract class CalorieResult with _$CalorieResult {
  const factory CalorieResult({
    @JsonKey(fromJson: _toString) required String url,
    @JsonKey(fromJson: _toString) required String message,
  }) = _CalorieResult;

  factory CalorieResult.fromJson(Map<String, Object?> json) =>
      _$CalorieResultFromJson(json);
}
