import 'package:nomoca_flutter/data/api/update_read_post_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/repository/authenticated.dart';

// ignore: one_member_abstracts
abstract class UpdateReadPostRepository with Authenticated {
  Future<void> updateReadPost({required int notificationId});
}

class UpdateReadPostRepositoryImpl extends UpdateReadPostRepository {
  UpdateReadPostRepositoryImpl(
      {required this.updateReadPostApi, required this.userDao});

  final UpdateReadPostApi updateReadPostApi;
  final UserDao userDao;

  @override
  Future<void> updateReadPost({required int notificationId}) async {
    final authenticationToken = getAuthenticationToken(userDao.get());
    await updateReadPostApi(
      authenticationToken: authenticationToken,
      notificationId: notificationId,
    );
  }
}
