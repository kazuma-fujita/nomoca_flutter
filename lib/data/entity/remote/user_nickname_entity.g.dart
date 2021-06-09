// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_nickname_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserNicknameEntity _$_$_UserNicknameEntityFromJson(
    Map<String, dynamic> json) {
  return $checkedNew(r'_$_UserNicknameEntity', json, () {
    final val = _$_UserNicknameEntity(
      id: $checkedConvert(json, 'id', (v) => v as int),
      nickname: $checkedConvert(json, 'name', (v) => v as String),
    );
    return val;
  }, fieldKeyMap: const {'nickname': 'name'});
}

Map<String, dynamic> _$_$_UserNicknameEntityToJson(
        _$_UserNicknameEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.nickname,
    };
