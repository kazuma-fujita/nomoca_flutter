import 'package:nomoca_flutter/data/api/create_user_api.dart';

// ignore: one_member_abstracts
abstract class CreateUserRepository {
  Future<void> createUser({
    required String mobilePhoneNumber,
    required String nickname,
  });
}

class CreateUserRepositoryImpl extends CreateUserRepository {
  CreateUserRepositoryImpl({required this.createUserApi});

  final CreateUserApi createUserApi;

  @override
  Future<void> createUser({
    required String mobilePhoneNumber,
    required String nickname,
  }) async {
    // TODO: UNFIXED
    const osVersion = '';
    const deviceName = '';
    await createUserApi(
      mobilePhoneNumber: mobilePhoneNumber,
      nickname: nickname,
      osVersion: osVersion,
      deviceName: deviceName,
    );
  }
}
