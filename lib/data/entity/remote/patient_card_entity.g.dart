// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_card_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PatientCardEntity _$_$_PatientCardEntityFromJson(Map<String, dynamic> json) {
  return $checkedNew(r'_$_PatientCardEntity', json, () {
    final val = _$_PatientCardEntity(
      nickname: $checkedConvert(json, 'name', (v) => v as String),
      qrCodeImageUrl:
          $checkedConvert(json, 'qr_code_image', (v) => v as String),
    );
    return val;
  }, fieldKeyMap: const {
    'nickname': 'name',
    'qrCodeImageUrl': 'qr_code_image'
  });
}

Map<String, dynamic> _$_$_PatientCardEntityToJson(
        _$_PatientCardEntity instance) =>
    <String, dynamic>{
      'name': instance.nickname,
      'qr_code_image': instance.qrCodeImageUrl,
    };
