import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/create_family_user_api.dart';
import 'package:nomoca_flutter/data/api/delete_family_user_api.dart';

// ignore: one_member_abstracts
abstract class DeleteFamilyUserRepository {
  Future<void> deleteUser({required int familyUserId});
}

class DeleteFamilyUserRepositoryImpl extends DeleteFamilyUserRepository {
  DeleteFamilyUserRepositoryImpl({required this.deleteFamilyUserApi});

  final DeleteFamilyUserApi deleteFamilyUserApi;

  @override
  Future<void> deleteUser({required int familyUserId}) async {
    // TODO: DBからtoken取得
    const authenticationToken = '${NomocaApiProperties.jwtPrefix} dummy';
    await deleteFamilyUserApi(
      authenticationToken: authenticationToken,
      familyUserId: familyUserId,
    );
  }
}
