import 'dart:convert';

import 'package:nomoca_flutter/data/api/keyword_search_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/remote/keyword_search_entity.dart';
import 'package:nomoca_flutter/data/repository/authenticated.dart';

// ignore: one_member_abstracts
abstract class KeywordSearchRepository with Authenticated {
  Future<List<KeywordSearchEntity>> fetchList({
    required String query,
    required int offset,
    required int limit,
    double? latitude,
    double? longitude,
  });
}

class KeywordSearchRepositoryImpl extends KeywordSearchRepository {
  KeywordSearchRepositoryImpl(
      {required this.keywordSearchApi, required this.userDao});

  final KeywordSearchApi keywordSearchApi;
  final UserDao userDao;

  @override
  Future<List<KeywordSearchEntity>> fetchList({
    required String query,
    required int offset,
    required int limit,
    double? latitude,
    double? longitude,
  }) async {
    final authenticationToken = getAuthenticationToken(userDao.get());
    try {
      final responseBody = await keywordSearchApi(
        authenticationToken: authenticationToken,
        query: query,
        offset: offset,
        limit: limit,
        latitude: latitude,
        longitude: longitude,
      );

      final decodedJson = json.decode(responseBody) as List<dynamic>;
      // Conversion json to entity.
      return decodedJson
          .map((dynamic itemJson) =>
              KeywordSearchEntity.fromJson(itemJson as Map<String, dynamic>))
          .toList();
    } on Exception catch (error) {
      throw Exception(error);
    }
  }
}

// class FakeKeywordSearchRepositoryImpl extends KeywordSearchRepository {
//   FakeKeywordSearchRepositoryImpl();
//   @override
//   Future<List<KeywordSearchEntity>> fetchList() async {
//     const contentsBaseUrl = 'https://contents-debug.nomoca.com';
//     return [
//       const KeywordSearchEntity(
//         id: 140188,
//         isRead: false,
//         detail: NotificationDetailEntity(
//             title: 'お知らせTitle1',
//             body: 'お知らせBody1',
//             contributor: 'テストクリニックからのお知らせ',
//             deliveryDate: '2021/06/21 12:15',
//             // imageUrl: null),
//             imageUrl:
//                 '$contentsBaseUrl/institutions/140188/image1/381e52949a3fb4ce444a6de59c8e1190.jpg'),
//       ),
//       const KeywrodSearchEntity(
//         id: 141338,
//         isRead: false,
//         detail: NotificationDetailEntity(
//             title: 'お知らせTitle2お知らせTitle2お知らせタイトル2お知らせタイトル2',
//             // ignore: lines_longer_than_80_chars
//             body:
//                 'お知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\n',
//             contributor: 'テスト歯科からのお知らせテスト歯科からのお知らせテスト歯科からのお知らせ',
//             deliveryDate: '2021/05/01 09:05',
//             // imageUrl: null),
//             imageUrl:
//                 '$contentsBaseUrl/institutions/141338/image1/a35d6ac6ad8258db2891a1bc69ae8c1b.jpg'),
//       ),
//     ];
//   }
// }
