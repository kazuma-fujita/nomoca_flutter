import 'package:nomoca_flutter/data/entity/remote/authentication_entity.dart';
import 'package:nomoca_flutter/data/repository/authentication_repository.dart';

class FakeAuthenticationRepositoryImpl extends AuthenticationRepository {
  FakeAuthenticationRepositoryImpl();

  @override
  Future<AuthenticationEntity> authentication({
    required String mobilePhoneNumber,
    required String authCode,
  }) async =>
      Future.delayed(const Duration(seconds: 1), () => Future.value());
}
