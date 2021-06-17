import 'dart:convert';

import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/update_user_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';

// ignore: one_member_abstracts
abstract class UpdateUserRepository {
  Future<UserNicknameEntity> updateUser({
    required int userId,
    required String nickname,
  });
}

class UpdateUserRepositoryImpl extends UpdateUserRepository {
  UpdateUserRepositoryImpl(
      {required this.updateUserApi, required this.userDao});

  final UpdateUserApi updateUserApi;
  final UserDao userDao;

  @override
  Future<UserNicknameEntity> updateUser({
    required int userId,
    required String nickname,
  }) async {
    // TODO: DBからtoken取得
    const authenticationToken = '${NomocaApiProperties.jwtPrefix} dummy';
    try {
      final responseBody = await updateUserApi(
        authenticationToken: authenticationToken,
        userId: userId,
        nickname: nickname,
      );
      final decodedJson = json.decode(responseBody) as dynamic;
      // Conversion json to entity.
      final entity =
          UserNicknameEntity.fromJson(decodedJson as Map<String, dynamic>);

      // Update nickname.
      await userDao.save(User()
        ..userId = userId
        ..nickname = nickname);

      return entity;
    } on Exception catch (error) {
      throw Exception(error);
    }
  }
}
