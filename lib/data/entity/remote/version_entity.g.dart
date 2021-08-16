// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VersionEntity _$_$_VersionEntityFromJson(Map<String, dynamic> json) {
  return $checkedNew(r'_$_VersionEntity', json, () {
    final val = _$_VersionEntity(
      version: $checkedConvert(json, 'version', (v) => v as String),
    );
    return val;
  });
}

Map<String, dynamic> _$_$_VersionEntityToJson(_$_VersionEntity instance) =>
    <String, dynamic>{
      'version': instance.version,
    };
