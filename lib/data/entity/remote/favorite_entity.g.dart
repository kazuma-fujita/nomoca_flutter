// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FavoriteEntity _$_$_FavoriteEntityFromJson(Map<String, dynamic> json) {
  return $checkedNew(r'_$_FavoriteEntity', json, () {
    final val = _$_FavoriteEntity(
      institutionId: $checkedConvert(json, 'institution_id', (v) => v as int),
      type: $checkedConvert(json, 'type', (v) => v as String),
      name: $checkedConvert(json, 'name', (v) => v as String),
      image1: $checkedConvert(json, 'image1', (v) => v as String?),
      image2: $checkedConvert(json, 'image2', (v) => v as String?),
      image3: $checkedConvert(json, 'image3', (v) => v as String?),
      image4: $checkedConvert(json, 'image4', (v) => v as String?),
      image5: $checkedConvert(json, 'image5', (v) => v as String?),
      userIds: $checkedConvert(json, 'end_user_ids',
          (v) => (v as List<dynamic>).map((e) => e as int).toList()),
      images: $checkedConvert(json, 'images',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
    );
    return val;
  }, fieldKeyMap: const {
    'institutionId': 'institution_id',
    'userIds': 'end_user_ids'
  });
}

Map<String, dynamic> _$_$_FavoriteEntityToJson(_$_FavoriteEntity instance) =>
    <String, dynamic>{
      'institution_id': instance.institutionId,
      'type': instance.type,
      'name': instance.name,
      'image1': instance.image1,
      'image2': instance.image2,
      'image3': instance.image3,
      'image4': instance.image4,
      'image5': instance.image5,
      'end_user_ids': instance.userIds,
      'images': instance.images,
    };
