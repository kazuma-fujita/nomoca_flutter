import 'dart:convert';

import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/update_family_user_api.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';

// ignore: one_member_abstracts
abstract class UpdateFamilyUserRepository {
  Future<UserNicknameEntity> updateUser({
    required int familyUserId,
    required String nickname,
  });
}

class UpdateFamilyUserRepositoryImpl extends UpdateFamilyUserRepository {
  UpdateFamilyUserRepositoryImpl({required this.updateFamilyUserApi});

  final UpdateFamilyUserApi updateFamilyUserApi;

  @override
  Future<UserNicknameEntity> updateUser({
    required int familyUserId,
    required String nickname,
  }) async {
    // TODO: DBからtoken取得
    const authenticationToken = '${NomocaApiProperties.jwtPrefix} dummy';
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

class FakeUpdateFamilyUserRepositoryImpl extends UpdateFamilyUserRepository {
  @override
  Future<UserNicknameEntity> updateUser({
    required int familyUserId,
    required String nickname,
  }) async {
    return const UserNicknameEntity(id: 1234, nickname: '次郎');
  }
}
