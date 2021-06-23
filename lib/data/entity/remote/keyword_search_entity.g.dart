// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyword_search_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_KeywordSearchEntity _$_$_KeywordSearchEntityFromJson(
    Map<String, dynamic> json) {
  return $checkedNew(r'_$_KeywordSearchEntity', json, () {
    final val = _$_KeywordSearchEntity(
      id: $checkedConvert(json, 'id', (v) => v as int),
      name: $checkedConvert(json, 'name', (v) => v as String),
      address: $checkedConvert(json, 'address', (v) => v as String),
      buildingName: $checkedConvert(json, 'building_name', (v) => v as String?),
      image1: $checkedConvert(json, 'image1', (v) => v as String?),
      image2: $checkedConvert(json, 'image2', (v) => v as String?),
      image3: $checkedConvert(json, 'image3', (v) => v as String?),
      image4: $checkedConvert(json, 'image4', (v) => v as String?),
      image5: $checkedConvert(json, 'image5', (v) => v as String?),
      isFavorite: $checkedConvert(json, 'is_favorite', (v) => v as bool),
      images: $checkedConvert(json, 'images',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
    );
    return val;
  }, fieldKeyMap: const {
    'buildingName': 'building_name',
    'isFavorite': 'is_favorite'
  });
}

Map<String, dynamic> _$_$_KeywordSearchEntityToJson(
        _$_KeywordSearchEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'building_name': instance.buildingName,
      'image1': instance.image1,
      'image2': instance.image2,
      'image3': instance.image3,
      'image4': instance.image4,
      'image5': instance.image5,
      'is_favorite': instance.isFavorite,
      'images': instance.images,
    };
