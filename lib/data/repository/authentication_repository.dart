import 'package:nomoca_flutter/data/api/authentication_api.dart';

abstract class PatientCardRepository {
  Future<void> signIn({
    required String mobilePhoneNumber,
    required String authCode,
    String? osVersion,
    String? deviceName,
  });

  Future<void> signUp({
    required String mobilePhoneNumber,
    required String nickname,
    String? osVersion,
    String? deviceName,
  });

  Future<void> sendShortMessage({
    required String mobilePhoneNumber,
  });

  Future<void> signOut();
}

class AuthenticationRepositoryImpl implements PatientCardRepository {
  AuthenticationRepositoryImpl({required this.authenticationApi});

  final AuthenticationApi authenticationApi;

  @override
  Future<void> signIn({
    required String mobilePhoneNumber,
    required String authCode,
    String? osVersion,
    String? deviceName,
  }) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signUp({
    required String mobilePhoneNumber,
    required String nickname,
    String? osVersion,
    String? deviceName,
  }) async {
    await authenticationApi.signUp(
      mobilePhoneNumber: mobilePhoneNumber,
      nickname: nickname,
      osVersion: osVersion,
      deviceName: deviceName,
    );
  }

  @override
  Future<void> sendShortMessage({required String mobilePhoneNumber}) {
    // TODO: implement sendShortMessage
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
