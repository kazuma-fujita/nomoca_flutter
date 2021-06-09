import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/update_family_user_api.dart';

// ignore: one_member_abstracts
abstract class UpdateFamilyUserRepository {
  Future<void> updateUser({
    required int familyUserId,
    required String nickname,
  });
}

class UpdateFamilyUserRepositoryImpl extends UpdateFamilyUserRepository {
  UpdateFamilyUserRepositoryImpl({required this.updateFamilyUserApi});

  final UpdateFamilyUserApi updateFamilyUserApi;

  @override
  Future<void> updateUser({
    required int familyUserId,
    required String nickname,
  }) async {
    // TODO: DBからtoken取得
    const authenticationToken = '${NomocaApiProperties.jwtPrefix} dummy';
    await updateFamilyUserApi(
      authenticationToken: authenticationToken,
      familyUserId: familyUserId,
      nickname: nickname,
    );
  }
}
