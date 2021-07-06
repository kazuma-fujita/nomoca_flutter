// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_patient_card_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FavoritePatientCardEntity _$_$_FavoritePatientCardEntityFromJson(
    Map<String, dynamic> json) {
  return $checkedNew(r'_$_FavoritePatientCardEntity', json, () {
    final val = _$_FavoritePatientCardEntity(
      institutionId: $checkedConvert(json, 'institution_id', (v) => v as int),
      userId: $checkedConvert(json, 'end_user_id', (v) => v as int),
      nickname: $checkedConvert(json, 'nickname', (v) => v as String),
      localId: $checkedConvert(json, 'local_id', (v) => v as String?),
      reserveDate: $checkedConvert(json, 'reserve_at', (v) => v as String?),
      lastReceptionDate:
          $checkedConvert(json, 'last_reception_at', (v) => v as String?),
      isPatient: $checkedConvert(json, 'is_patient', (v) => v as bool),
    );
    return val;
  }, fieldKeyMap: const {
    'institutionId': 'institution_id',
    'userId': 'end_user_id',
    'localId': 'local_id',
    'reserveDate': 'reserve_at',
    'lastReceptionDate': 'last_reception_at',
    'isPatient': 'is_patient'
  });
}

Map<String, dynamic> _$_$_FavoritePatientCardEntityToJson(
        _$_FavoritePatientCardEntity instance) =>
    <String, dynamic>{
      'institution_id': instance.institutionId,
      'end_user_id': instance.userId,
      'nickname': instance.nickname,
      'local_id': instance.localId,
      'reserve_at': instance.reserveDate,
      'last_reception_at': instance.lastReceptionDate,
      'is_patient': instance.isPatient,
    };
