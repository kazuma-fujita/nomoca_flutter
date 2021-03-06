import 'dart:convert';

import 'package:nomoca_flutter/constants/nomoca_urls.dart';
import 'package:nomoca_flutter/data/api/fetch_notification_list_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/remote/notification_entity.dart';
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
    final authenticationToken = getAuthenticationToken(userDao.get());
    try {
      final responseBody = await fetchNotificationListApi(
          authenticationToken: authenticationToken);

      final decodedJson = json.decode(responseBody) as List<dynamic>;
      // Conversion json to entity.
      final list = decodedJson
          .map((dynamic itemJson) =>
              NotificationEntity.fromJson(itemJson as Map<String, dynamic>))
          .toList();
      return list
          .map(
            (entity) => entity.copyWith(
                detail: entity.detail.copyWith(
              imageUrl: entity.detail.imageUrl != null
                  ? '${NomocaUrls.contentsBaseUrl}/${entity.detail.imageUrl}'
                  : null,
            )),
          )
          .toList();
    } on Exception catch (error) {
      throw Exception(error);
    }
  }
}

class FakeFetchNotificationListRepositoryImpl
    extends FetchNotificationListRepository {
  FakeFetchNotificationListRepositoryImpl();
  @override
  Future<List<NotificationEntity>> fetchList() async {
    const contentsBaseUrl = 'https://contents-debug.nomoca.com';
    return [
      const NotificationEntity(
        id: 140188,
        isRead: false,
        detail: NotificationDetailEntity(
            title: '????????????Title1',
            body: '????????????Body1',
            contributor: '?????????????????????????????????????????????',
            deliveryDate: '2021/06/21 12:15',
            // imageUrl: null),
            imageUrl:
                '$contentsBaseUrl/institutions/140188/image1/381e52949a3fb4ce444a6de59c8e1190.jpg'),
      ),
      const NotificationEntity(
        id: 141338,
        isRead: false,
        detail: NotificationDetailEntity(
            title: '????????????Title2????????????Title2????????????????????????2????????????????????????2',
            body: '????????????Body2\n????????????Body2\n????????????Body2\n????????????Body2\n????????????Body2\n',
            contributor: '????????????????????????????????????????????????????????????????????????????????????????????????????????????',
            deliveryDate: '2021/05/01 09:05',
            // imageUrl: null),
            imageUrl:
                '$contentsBaseUrl/institutions/141338/image1/a35d6ac6ad8258db2891a1bc69ae8c1b.jpg'),
      ),
    ];
  }
}
