import 'package:nomoca_flutter/data/api/delete_local_id_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/repository/authenticated.dart';

// ignore: one_member_abstracts
abstract class DeleteLocalIdRepository with Authenticated {
  Future<void> deleteLocalId({
    required int userId,
    required int institutionId,
  });
}

class DeleteLocalIdRepositoryImpl extends DeleteLocalIdRepository {
  DeleteLocalIdRepositoryImpl(
      {required this.deleteLocalIdApi, required this.userDao});

  final DeleteLocalIdApi deleteLocalIdApi;
  final UserDao userDao;

  @override
  Future<void> deleteLocalId({
    required int userId,
    required int institutionId,
  }) async {
    final authenticationToken = getAuthenticationToken(userDao.get());
    await deleteLocalIdApi(
      authenticationToken: authenticationToken,
      userId: userId,
      institutionId: institutionId,
    );
  }
}
