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
