// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AuthenticationEntity _$_$_AuthenticationEntityFromJson(
    Map<String, dynamic> json) {
  return $checkedNew(r'_$_AuthenticationEntity', json, () {
    final val = _$_AuthenticationEntity(
      authenticationToken: $checkedConvert(json, 'token', (v) => v as String),
      userId: $checkedConvert(json, 'end_user_id', (v) => v as int),
      nickname: $checkedConvert(json, 'name', (v) => v as String),
    );
    return val;
  }, fieldKeyMap: const {
    'authenticationToken': 'token',
    'userId': 'end_user_id',
    'nickname': 'name'
  });
}

Map<String, dynamic> _$_$_AuthenticationEntityToJson(
        _$_AuthenticationEntity instance) =>
    <String, dynamic>{
      'token': instance.authenticationToken,
      'end_user_id': instance.userId,
      'name': instance.nickname,
    };
