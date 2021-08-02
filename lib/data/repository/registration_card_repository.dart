import 'package:nomoca_flutter/data/api/registration_card_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/repository/authenticated.dart';

// ignore: one_member_abstracts
abstract class RegistrationCardRepository with Authenticated {
  Future<void> registration({
    required int sourceUserId,
    int? familyUserId,
  });
}

class RegistrationCardRepositoryImpl extends RegistrationCardRepository {
  RegistrationCardRepositoryImpl(
      {required this.registrationCardApi, required this.userDao});

  final RegistrationCardApi registrationCardApi;
  final UserDao userDao;

  @override
  Future<void> registration({
    required int sourceUserId,
    int? familyUserId,
  }) async {
    final authenticationToken = getAuthenticationToken(userDao.get());
    await registrationCardApi(
      authenticationToken: authenticationToken,
      sourceUserId: sourceUserId,
      familyUserId: familyUserId,
    );
  }
}

class FakeRegistrationCardRepositoryImpl extends RegistrationCardRepository {
  FakeRegistrationCardRepositoryImpl();

  @override
  Future<void> registration({
    required int sourceUserId,
    int? familyUserId,
  }) async {
    print('FakeRegistrationCardRepositoryImpl $sourceUserId / $familyUserId');
    return Future.delayed(const Duration(seconds: 3), () => Future.value());
  }
}
