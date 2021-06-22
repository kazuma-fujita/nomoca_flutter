import 'dart:convert';

import 'package:nomoca_flutter/data/api/fetch_family_user_list_api.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/repository/authenticated.dart';

// ignore: one_member_abstracts
abstract class FetchFamilyUserListRepository with Authenticated {
  Future<List<UserNicknameEntity>> fetchList();
}

class FetchFamilyUserListRepositoryImpl extends FetchFamilyUserListRepository {
  FetchFamilyUserListRepositoryImpl(
      {required this.fetchFamilyUserListApi, required this.userDao});

  final FetchFamilyUserListApi fetchFamilyUserListApi;
  final UserDao userDao;

  @override
  Future<List<UserNicknameEntity>> fetchList() async {
    final authenticationToken = getAuthenticationToken(userDao.get());
    try {
      final responseBody = await fetchFamilyUserListApi(
          authenticationToken: authenticationToken);

      final decodedJson = json.decode(responseBody) as List<dynamic>;
      // Conversion json to entity.
      return decodedJson
          .map((dynamic itemJson) =>
              UserNicknameEntity.fromJson(itemJson as Map<String, dynamic>))
          .toList();
    } on Exception catch (error) {
      throw Exception(error);
    }
  }
}

class FakeFetchFamilyUserListRepositoryImpl
    extends FetchFamilyUserListRepository {
  @override
  Future<List<UserNicknameEntity>> fetchList() async {
    return [const UserNicknameEntity(id: 1234, nickname: '花子')];
  }
}
