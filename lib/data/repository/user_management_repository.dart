import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/errors/authentication_error.dart';

// ignore: one_member_abstracts
abstract class UserManagementRepository {
  UserNicknameEntity getUser();
}

class UserManagementRepositoryImpl extends UserManagementRepository {
  UserManagementRepositoryImpl({required this.userDao});

  final UserDao userDao;

  @override
  UserNicknameEntity getUser() {
    final user = userDao.get();
    if (user == null ||
        user.authenticationToken == null ||
        user.userId == null ||
        user.nickname == null) {
      throw AuthenticationError();
    }
    return UserNicknameEntity(id: user.userId!, nickname: user.nickname!);
  }
}
