import 'dart:convert';

import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/update_family_user_api.dart';
import 'package:nomoca_flutter/data/api/update_user_api.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';

// ignore: one_member_abstracts
abstract class UpdateUserRepository {
  Future<UserNicknameEntity> updateUser({
    required int userId,
    required String nickname,
  });
}

class UpdateUserRepositoryImpl extends UpdateUserRepository {
  UpdateUserRepositoryImpl({required this.updateUserApi});

  final UpdateUserApi updateUserApi;

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
      return UserNicknameEntity.fromJson(decodedJson as Map<String, dynamic>);
    } on Exception catch (error) {
      throw Exception(error);
    }
  }
}
