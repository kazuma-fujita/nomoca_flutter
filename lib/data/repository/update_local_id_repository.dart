import 'package:nomoca_flutter/data/api/update_local_id_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/repository/authenticated.dart';

// ignore: one_member_abstracts
abstract class UpdateLocalIdRepository with Authenticated {
  Future<void> updateLocalId({
    required int userId,
    required int institutionId,
  });
}

class UpdateLocalIdRepositoryImpl extends UpdateLocalIdRepository {
  UpdateLocalIdRepositoryImpl(
      {required this.updateLocalIdApi, required this.userDao});

  final UpdateLocalIdApi updateLocalIdApi;
  final UserDao userDao;

  @override
  Future<void> updateLocalId({
    required int userId,
    required int institutionId,
  }) async {
    final authenticationToken = getAuthenticationToken(userDao.get());
    await updateLocalIdApi(
      authenticationToken: authenticationToken,
      userId: userId,
      institutionId: institutionId,
    );
  }
}
