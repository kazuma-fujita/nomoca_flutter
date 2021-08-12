import 'package:nomoca_flutter/data/repository/create_user_repository.dart';

class FakeCreateUserRepositoryImpl extends CreateUserRepository {
  FakeCreateUserRepositoryImpl();

  @override
  Future<void> createUser({
    required String mobilePhoneNumber,
    required String nickname,
  }) async =>
      Future.delayed(const Duration(seconds: 3), () => Future.value());
}
