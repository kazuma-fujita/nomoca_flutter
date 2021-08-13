import 'dart:convert';

import 'package:nomoca_flutter/data/api/create_family_user_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/authenticated.dart';

// ignore: one_member_abstracts
abstract class CreateFamilyUserRepository with Authenticated {
  Future<UserNicknameEntity> createUser({required String nickname});
}

class CreateFamilyUserRepositoryImpl extends CreateFamilyUserRepository {
  CreateFamilyUserRepositoryImpl(
      {required this.createFamilyUserApi, required this.userDao});

  final CreateFamilyUserApi createFamilyUserApi;
  final UserDao userDao;

  @override
  Future<UserNicknameEntity> createUser({required String nickname}) async {
    final authenticationToken = getAuthenticationToken(userDao.get());
    try {
      final responseBody = await createFamilyUserApi(
        authenticationToken: authenticationToken,
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
