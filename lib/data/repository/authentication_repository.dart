import 'package:nomoca_flutter/data/api/authentication_api.dart';

// ignore: one_member_abstracts
abstract class AuthenticationRepository {
  Future<void> authentication({
    required String mobilePhoneNumber,
    required String authCode,
    String? osVersion,
    String? deviceName,
  });
}

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  AuthenticationRepositoryImpl({required this.authenticationApi});

  final AuthenticationApi authenticationApi;

  @override
  Future<void> authentication({
    required String mobilePhoneNumber,
    required String authCode,
    String? osVersion,
    String? deviceName,
  }) async {
    await authenticationApi(
      mobilePhoneNumber: mobilePhoneNumber,
      authCode: authCode,
      osVersion: osVersion,
      deviceName: deviceName,
    );
  }
}

class FakeAuthenticationRepositoryImpl extends AuthenticationRepository {
  FakeAuthenticationRepositoryImpl();

  @override
  Future<void> authentication({
    required String mobilePhoneNumber,
    required String authCode,
    String? osVersion,
    String? deviceName,
  }) async =>
      Future.delayed(const Duration(seconds: 1), () => Future.value());
}
