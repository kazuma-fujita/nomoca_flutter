import 'package:nomoca_flutter/data/api/delete_family_user_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/repository/authenticated.dart';

// ignore: one_member_abstracts
abstract class DeleteFamilyUserRepository with Authenticated {
  Future<void> deleteUser({required int familyUserId});
}

class DeleteFamilyUserRepositoryImpl extends DeleteFamilyUserRepository {
  DeleteFamilyUserRepositoryImpl(
      {required this.deleteFamilyUserApi, required this.userDao});

  final DeleteFamilyUserApi deleteFamilyUserApi;
  final UserDao userDao;

  @override
  Future<void> deleteUser({required int familyUserId}) async {
    final authenticationToken = getAuthenticationToken(userDao.get());
    await deleteFamilyUserApi(
      authenticationToken: authenticationToken,
      familyUserId: familyUserId,
    );
  }
}
