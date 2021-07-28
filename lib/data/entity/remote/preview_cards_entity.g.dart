// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preview_cards_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PreviewCardsEntity _$_$_PreviewCardsEntityFromJson(
    Map<String, dynamic> json) {
  return $checkedNew(r'_$_PreviewCardsEntity', json, () {
    final val = _$_PreviewCardsEntity(
      sourceUserId: $checkedConvert(json, 'id', (v) => v as int),
      patients: $checkedConvert(
          json,
          'patients',
          (v) => (v as List<dynamic>)
              .map((e) =>
                  PreviewCardPatientEntity.fromJson(e as Map<String, dynamic>))
              .toList()),
    );
    return val;
  }, fieldKeyMap: const {'sourceUserId': 'id'});
}

Map<String, dynamic> _$_$_PreviewCardsEntityToJson(
        _$_PreviewCardsEntity instance) =>
    <String, dynamic>{
      'id': instance.sourceUserId,
      'patients': instance.patients,
    };

_$_PreviewCardPatientEntity _$_$_PreviewCardPatientEntityFromJson(
    Map<String, dynamic> json) {
  return $checkedNew(r'_$_PreviewCardPatientEntity', json, () {
    final val = _$_PreviewCardPatientEntity(
      nameKana: $checkedConvert(json, 'name_kana', (v) => v as String),
      localId: $checkedConvert(json, 'local_id', (v) => v as String),
      institution: $checkedConvert(
          json,
          'institution',
          (v) =>
              PreviewCardInstitutionEntity.fromJson(v as Map<String, dynamic>)),
    );
    return val;
  }, fieldKeyMap: const {'nameKana': 'name_kana', 'localId': 'local_id'});
}

Map<String, dynamic> _$_$_PreviewCardPatientEntityToJson(
        _$_PreviewCardPatientEntity instance) =>
    <String, dynamic>{
      'name_kana': instance.nameKana,
      'local_id': instance.localId,
      'institution': instance.institution,
    };

_$_PreviewCardInstitutionEntity _$_$_PreviewCardInstitutionEntityFromJson(
    Map<String, dynamic> json) {
  return $checkedNew(r'_$_PreviewCardInstitutionEntity', json, () {
    final val = _$_PreviewCardInstitutionEntity(
      institutionId: $checkedConvert(json, 'id', (v) => v as int),
      institutionName: $checkedConvert(json, 'name', (v) => v as String),
    );
    return val;
  }, fieldKeyMap: const {'institutionId': 'id', 'institutionName': 'name'});
}

Map<String, dynamic> _$_$_PreviewCardInstitutionEntityToJson(
        _$_PreviewCardInstitutionEntity instance) =>
    <String, dynamic>{
      'id': instance.institutionId,
      'name': instance.institutionName,
    };
