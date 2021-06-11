import 'dart:convert';

import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/create_family_user_api.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';

// ignore: one_member_abstracts
abstract class CreateFamilyUserRepository {
  Future<UserNicknameEntity> createUser({required String nickname});
}

class CreateFamilyUserRepositoryImpl extends CreateFamilyUserRepository {
  CreateFamilyUserRepositoryImpl({required this.createFamilyUserApi});

  final CreateFamilyUserApi createFamilyUserApi;

  @override
  Future<UserNicknameEntity> createUser({required String nickname}) async {
    // TODO: DBからtoken取得
    const authenticationToken = '${NomocaApiProperties.jwtPrefix} dummy';
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

class FakeCreateFamilyUserRepositoryImpl extends CreateFamilyUserRepository {
  @override
  Future<UserNicknameEntity> createUser({required String nickname}) async {
    return const UserNicknameEntity(id: 1234, nickname: '花子');
  }
}
