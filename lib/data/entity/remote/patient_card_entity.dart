import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient_card_entity.freezed.dart';
part 'patient_card_entity.g.dart';

@freezed
class PatientCardEntity with _$PatientCardEntity {
  const factory PatientCardEntity({
    @JsonKey(name: 'name') required String nickname,
    @JsonKey(name: 'qr_code_image') required String qrCodeImageUrl,
  }) = _PatientCardEntity;

  factory PatientCardEntity.fromJson(Map<String, dynamic> json) =>
      _$PatientCardEntityFromJson(json);
}
