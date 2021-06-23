import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_list_action.freezed.dart';

@freezed
class NotificationListAction with _$NotificationListAction {
  const factory NotificationListAction.fetchList() = FetchList;
  const factory NotificationListAction.isRead(int notificationId) = IsRead;
}
