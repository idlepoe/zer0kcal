import 'package:freezed_annotation/freezed_annotation.dart';

part 'calorie_result.freezed.dart';

part 'calorie_result.g.dart';

String _stringFromJson(dynamic s) {
  return s.toString();
}

@freezed
abstract class CalorieResult with _$CalorieResult {
  const factory CalorieResult({
    @JsonKey(fromJson: _stringFromJson) required String url,
    @JsonKey(fromJson: _stringFromJson) required String result,
  }) = _CalorieResult;

  factory CalorieResult.fromJson(Map<String, Object?> json) =>
      _$CalorieResultFromJson(json);
}
