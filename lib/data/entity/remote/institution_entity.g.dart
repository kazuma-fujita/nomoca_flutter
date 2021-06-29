// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'institution_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_InstitutionEntity _$_$_InstitutionEntityFromJson(Map<String, dynamic> json) {
  return $checkedNew(r'_$_InstitutionEntity', json, () {
    final val = _$_InstitutionEntity(
      id: $checkedConvert(json, 'id', (v) => v as int),
      name: $checkedConvert(json, 'name', (v) => v as String),
      type: $checkedConvert(json, 'type', (v) => v as String),
      category: $checkedConvert(json, 'category', (v) => v as String),
      feature: $checkedConvert(json, 'feature', (v) => v as String?),
      businessHour: $checkedConvert(json, 'business_hour', (v) => v as String?),
      businessHoliday:
          $checkedConvert(json, 'business_holiday', (v) => v as String?),
      address: $checkedConvert(json, 'address', (v) => v as String),
      buildingName: $checkedConvert(json, 'building_name', (v) => v as String?),
      access: $checkedConvert(json, 'access', (v) => v as String?),
      title1: $checkedConvert(json, 'title1', (v) => v as String?),
      body1: $checkedConvert(json, 'body1', (v) => v as String?),
      title2: $checkedConvert(json, 'title2', (v) => v as String?),
      body2: $checkedConvert(json, 'body2', (v) => v as String?),
      title3: $checkedConvert(json, 'title3', (v) => v as String?),
      body3: $checkedConvert(json, 'body3', (v) => v as String?),
      image1: $checkedConvert(json, 'image1', (v) => v as String?),
      image2: $checkedConvert(json, 'image2', (v) => v as String?),
      image3: $checkedConvert(json, 'image3', (v) => v as String?),
      image4: $checkedConvert(json, 'image4', (v) => v as String?),
      image5: $checkedConvert(json, 'image5', (v) => v as String?),
      phoneNumber: $checkedConvert(json, 'phone_no', (v) => v as String),
      webSiteUrl: $checkedConvert(json, 'web_site_url', (v) => v as String?),
      reserveUrl: $checkedConvert(json, 'reserve_url', (v) => v as String?),
      longitude:
          $checkedConvert(json, 'longitude', (v) => (v as num).toDouble()),
      latitude: $checkedConvert(json, 'latitude', (v) => (v as num).toDouble()),
      isFavorite: $checkedConvert(json, 'is_favorite', (v) => v as bool),
      medicalDocumentUrl:
          $checkedConvert(json, 'medical_document_url', (v) => v as String?),
      isPhoneButtonHidden:
          $checkedConvert(json, 'is_phone_button_hidden', (v) => v as bool),
      images: $checkedConvert(json, 'images',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
    );
    return val;
  }, fieldKeyMap: const {
    'businessHour': 'business_hour',
    'businessHoliday': 'business_holiday',
    'buildingName': 'building_name',
    'phoneNumber': 'phone_no',
    'webSiteUrl': 'web_site_url',
    'reserveUrl': 'reserve_url',
    'isFavorite': 'is_favorite',
    'medicalDocumentUrl': 'medical_document_url',
    'isPhoneButtonHidden': 'is_phone_button_hidden'
  });
}

Map<String, dynamic> _$_$_InstitutionEntityToJson(
        _$_InstitutionEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'category': instance.category,
      'feature': instance.feature,
      'business_hour': instance.businessHour,
      'business_holiday': instance.businessHoliday,
      'address': instance.address,
      'building_name': instance.buildingName,
      'access': instance.access,
      'title1': instance.title1,
      'body1': instance.body1,
      'title2': instance.title2,
      'body2': instance.body2,
      'title3': instance.title3,
      'body3': instance.body3,
      'image1': instance.image1,
      'image2': instance.image2,
      'image3': instance.image3,
      'image4': instance.image4,
      'image5': instance.image5,
      'phone_no': instance.phoneNumber,
      'web_site_url': instance.webSiteUrl,
      'reserve_url': instance.reserveUrl,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'is_favorite': instance.isFavorite,
      'medical_document_url': instance.medicalDocumentUrl,
      'is_phone_button_hidden': instance.isPhoneButtonHidden,
      'images': instance.images,
    };
