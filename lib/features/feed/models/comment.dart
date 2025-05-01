import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'culturalEventInfoDetail.freezed.dart';

part 'culturalEventInfoDetail.g.dart';

String _toString(dynamic s) {
  return s is String ? s : "";
}

DateTime _fromTimestamp(dynamic value) {
  if (value == null) return DateTime.now();
  if (value is Map<String, dynamic> && value.containsKey('_seconds')) {
    return DateTime.fromMillisecondsSinceEpoch(value['_seconds'] * 1000);
  }
  return value is Timestamp ? (value as Timestamp).toDate() : DateTime.now();
}

int _fromInt(dynamic value) => value is int ? value : 0;

@freezed
abstract class CulturalEventInfoDetail with _$CulturalEventInfoDetail {
  const factory CulturalEventInfoDetail({
    @JsonKey(fromJson: _toString) required String CODENAME,
    @JsonKey(fromJson: _toString) required String GUNAME,
    @JsonKey(fromJson: _toString) required String TITLE,
    @JsonKey(fromJson: _toString) required String DATE,
    @JsonKey(fromJson: _toString) required String PLACE,
    @JsonKey(fromJson: _toString) required String ORG_NAME,
    @JsonKey(fromJson: _toString) required String USE_TRGT,
    @JsonKey(fromJson: _toString) required String USE_FEE,
    @JsonKey(fromJson: _toString) required String PLAYER,
    @JsonKey(fromJson: _toString) required String PROGRAM,
    @JsonKey(fromJson: _toString) required String ETC_DESC,
    @JsonKey(fromJson: _toString) required String ORG_LINK,
    @JsonKey(fromJson: _toString) required String MAIN_IMG,
    @JsonKey(fromJson: _toString) required String RGSTDATE,
    @JsonKey(fromJson: _toString) required String TICKET,
    @JsonKey(fromJson: _toString) required String STRTDATE,
    @JsonKey(fromJson: _toString) required String END_DATE,
    @JsonKey(fromJson: _toString) required String THEMECODE,
    @JsonKey(fromJson: _toString) required String LOT,
    @JsonKey(fromJson: _toString) required String LAT,
    @JsonKey(fromJson: _toString) required String IS_FREE,
    @JsonKey(fromJson: _toString) required String HMPG_ADDR,
    @JsonKey(fromJson: _toDouble) required double DISTANCE,
  }) = _CulturalEventInfoDetail;

  factory CulturalEventInfoDetail.fromJson(Map<String, Object?> json) => _$CulturalEventInfoDetailFromJson(json);
}
