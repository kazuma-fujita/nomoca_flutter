// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NotificationEntity _$_$_NotificationEntityFromJson(
    Map<String, dynamic> json) {
  return $checkedNew(r'_$_NotificationEntity', json, () {
    final val = _$_NotificationEntity(
      id: $checkedConvert(json, 'id', (v) => v as int),
      isRead: $checkedConvert(json, 'is_read', (v) => v as bool),
      detail: $checkedConvert(json, 'notify',
          (v) => NotificationDetailEntity.fromJson(v as Map<String, dynamic>)),
    );
    return val;
  }, fieldKeyMap: const {'isRead': 'is_read', 'detail': 'notify'});
}

Map<String, dynamic> _$_$_NotificationEntityToJson(
        _$_NotificationEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'is_read': instance.isRead,
      'notify': instance.detail,
    };

_$_NotificationDetailEntity _$_$_NotificationDetailEntityFromJson(
    Map<String, dynamic> json) {
  return $checkedNew(r'_$_NotificationDetailEntity', json, () {
    final val = _$_NotificationDetailEntity(
      title: $checkedConvert(json, 'title', (v) => v as String),
      body: $checkedConvert(json, 'body', (v) => v as String),
      contributor: $checkedConvert(json, 'contributor', (v) => v as String),
      deliveryDate: $checkedConvert(json, 'send_at', (v) => v as String),
      imageUrl: $checkedConvert(json, 'image1', (v) => v as String?),
    );
    return val;
  }, fieldKeyMap: const {'deliveryDate': 'send_at', 'imageUrl': 'image1'});
}

Map<String, dynamic> _$_$_NotificationDetailEntityToJson(
        _$_NotificationDetailEntity instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'contributor': instance.contributor,
      'send_at': instance.deliveryDate,
      'image1': instance.imageUrl,
    };
