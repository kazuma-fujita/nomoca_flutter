import 'dart:convert';

import 'package:nomoca_flutter/constants/nomoca_urls.dart';
import 'package:nomoca_flutter/data/api/fetch_favorite_list_api.dart';
import 'package:nomoca_flutter/data/api/fetch_notification_list_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/remote/favorite_entity.dart';
import 'package:nomoca_flutter/data/entity/remote/notification_entity.dart';
import 'package:nomoca_flutter/data/repository/authenticated.dart';

// ignore: one_member_abstracts
abstract class FetchFavoriteListRepository with Authenticated {
  Future<List<FavoriteEntity>> fetchList();
}

class FetchFavoriteListRepositoryImpl extends FetchFavoriteListRepository {
  FetchFavoriteListRepositoryImpl(
      {required this.fetchFavoriteListApi, required this.userDao});

  final FetchFavoriteListApi fetchFavoriteListApi;
  final UserDao userDao;

  @override
  Future<List<FavoriteEntity>> fetchList() async {
    final authenticationToken = getAuthenticationToken(userDao.get());
    try {
      final responseBody =
          await fetchFavoriteListApi(authenticationToken: authenticationToken);

      final decodedJson = json.decode(responseBody) as List<dynamic>;
      // Conversion json to entity.
      final list = decodedJson
          .map((dynamic itemJson) =>
              FavoriteEntity.fromJson(itemJson as Map<String, dynamic>))
          .toList();

      return list.map((entity) {
        final images = <String>[];
        if (entity.image1 != null) {
          images.add('${NomocaUrls.contentsBaseUrl}/${entity.image1}');
        }
        if (entity.image2 != null) {
          images.add('${NomocaUrls.contentsBaseUrl}/${entity.image2}');
        }
        if (entity.image3 != null) {
          images.add('${NomocaUrls.contentsBaseUrl}/${entity.image3}');
        }
        if (entity.image4 != null) {
          images.add('${NomocaUrls.contentsBaseUrl}/${entity.image4}');
        }
        if (entity.image5 != null) {
          images.add('${NomocaUrls.contentsBaseUrl}/${entity.image5}');
        }
        return entity.copyWith(
          images: images,
        );
      }).toList();
    } on Exception catch (error) {
      throw Exception(error);
    }
  }
}

class FakeFetchFavoriteListRepositoryImpl extends FetchFavoriteListRepository {
  FakeFetchFavoriteListRepositoryImpl();

  static const contentsBaseUrl = 'https://contents.nomoca.com';
  final entities = [
    const FavoriteEntity(
      institutionId: 92506,
      type: 'clinic',
      name: '渋谷リーフクリニック',
      images: null,
      userIds: [199, 200, 201],
    ),
    const FavoriteEntity(
      institutionId: 90093,
      type: 'dentistry',
      name: '小笠原歯科',
      images: [
        '$contentsBaseUrl/institutions/100027/image1/e907cf5540089bcdb1787a2d979e6a7b.jpg',
        '$contentsBaseUrl/institutions/100027/image4/8191a0e68a83a305c1f5c007b3ae1225.jpg',
        '$contentsBaseUrl/institutions/100027/image5/149e69d2d9726d61c98a05329e57bea6.jpg',
        '$contentsBaseUrl/institutions/100620/image5/f6d2d5248c0e35a9b094ed1c0d092102.jpg',
        '$contentsBaseUrl/institutions/102125/image3/bccffca6b7d7b44e951a0d80d6ab6586.jpg',
      ],
      userIds: [199, 200, 201],
    ),
  ];

  @override
  Future<List<FavoriteEntity>> fetchList() async =>
      Future.delayed(const Duration(seconds: 0), () => entities);
}
