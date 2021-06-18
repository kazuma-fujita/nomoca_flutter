import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_entity.freezed.dart';
part 'notification_entity.g.dart';

@freezed
class NotificationEntity with _$NotificationEntity {
  const factory NotificationEntity({
    required int id,
    @JsonKey(name: 'is_read') required bool isRead,
    @JsonKey(name: 'notify') required NotificationDetailEntity detail,
  }) = _NotificationEntity;

  factory NotificationEntity.fromJson(Map<String, dynamic> json) =>
      _$NotificationEntityFromJson(json);
}

@freezed
class NotificationDetailEntity with _$NotificationDetailEntity {
  const factory NotificationDetailEntity({
    required String title,
    required String body,
    required String contributor,
    @JsonKey(name: 'send_at') required String deliveryDate,
    @JsonKey(name: 'image1') required String? imageUrl,
  }) = _NotificationDetailEntity;

  factory NotificationDetailEntity.fromJson(Map<String, dynamic> json) =>
      _$NotificationDetailEntityFromJson(json);
}
