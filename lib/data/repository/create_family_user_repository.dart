import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/create_family_user_api.dart';

// ignore: one_member_abstracts
abstract class CreateFamilyUserRepository {
  Future<void> createUser({required String nickname});
}

class CreateFamilyUserRepositoryImpl extends CreateFamilyUserRepository {
  CreateFamilyUserRepositoryImpl({required this.createFamilyUserApi});

  final CreateFamilyUserApi createFamilyUserApi;

  @override
  Future<void> createUser({required String nickname}) async {
    // TODO: DBからtoken取得
    const authenticationToken = '${NomocaApiProperties.jwtPrefix} dummy';
    await createFamilyUserApi(
      authenticationToken: authenticationToken,
      nickname: nickname,
    );
  }
}
