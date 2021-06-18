import 'dart:convert';

import 'package:nomoca_flutter/data/api/fetch_family_user_list_api.dart';
import 'package:nomoca_flutter/data/api/fetch_notification_list_api.dart';
import 'package:nomoca_flutter/data/entity/remote/notification_entity.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/repository/authenticated.dart';

// ignore: one_member_abstracts
abstract class FetchNotificationListRepository with Authenticated {
  Future<List<NotificationEntity>> fetchList();
}

class FetchNotificationListRepositoryImpl
    extends FetchNotificationListRepository {
  FetchNotificationListRepositoryImpl(
      {required this.fetchNotificationListApi, required this.userDao});

  final FetchNotificationListApi fetchNotificationListApi;
  final UserDao userDao;

  @override
  Future<List<NotificationEntity>> fetchList() async {
    final user = userDao.get();
    final authenticationToken = getAuthenticationToken(user);
    try {
      final responseBody = await fetchNotificationListApi(
          authenticationToken: authenticationToken);

      final decodedJson = json.decode(responseBody) as List<dynamic>;
      // Conversion json to entity.
      return decodedJson
          .map((dynamic itemJson) =>
              NotificationEntity.fromJson(itemJson as Map<String, dynamic>))
          .toList();
    } on Exception catch (error) {
      throw Exception(error);
    }
  }
}
