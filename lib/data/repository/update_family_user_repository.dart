import 'dart:convert';

import 'package:nomoca_flutter/data/api/update_family_user_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/authenticated.dart';

// ignore: one_member_abstracts
abstract class UpdateFamilyUserRepository with Authenticated {
  Future<UserNicknameEntity> updateUser({
    required int familyUserId,
    required String nickname,
  });
}

class UpdateFamilyUserRepositoryImpl extends UpdateFamilyUserRepository {
  UpdateFamilyUserRepositoryImpl(
      {required this.updateFamilyUserApi, required this.userDao});

  final UpdateFamilyUserApi updateFamilyUserApi;
  final UserDao userDao;

  @override
  Future<UserNicknameEntity> updateUser({
    required int familyUserId,
    required String nickname,
  }) async {
    final authenticationToken = getAuthenticationToken(userDao.get());
    try {
      final responseBody = await updateFamilyUserApi(
        authenticationToken: authenticationToken,
        familyUserId: familyUserId,
        nickname: nickname,
      );
      final decodedJson = json.decode(responseBody) as dynamic;
      // Conversion json to entity.
      return UserNicknameEntity.fromJson(decodedJson as Map<String, dynamic>);
    } on Exception catch (error) {
      throw Exception(error);
    }
  }
}
