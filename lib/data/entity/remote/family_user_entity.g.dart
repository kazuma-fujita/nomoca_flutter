// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FamilyUserEntity _$_$_FamilyUserEntityFromJson(Map<String, dynamic> json) {
  return $checkedNew(r'_$_FamilyUserEntity', json, () {
    final val = _$_FamilyUserEntity(
      id: $checkedConvert(json, 'id', (v) => v as int),
      nickname: $checkedConvert(json, 'name', (v) => v as String),
    );
    return val;
  }, fieldKeyMap: const {'nickname': 'name'});
}

Map<String, dynamic> _$_$_FamilyUserEntityToJson(
        _$_FamilyUserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.nickname,
    };
