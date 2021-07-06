import 'package:nomoca_flutter/data/api/delete_next_reserve_date_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/repository/authenticated.dart';

// ignore: one_member_abstracts
abstract class DeleteNextReserveDateRepository with Authenticated {
  Future<void> deleteNextReserveDate({
    required int userId,
    required int institutionId,
  });
}

class DeleteNextReserveDateRepositoryImpl
    extends DeleteNextReserveDateRepository {
  DeleteNextReserveDateRepositoryImpl(
      {required this.deleteNextReserveDateApi, required this.userDao});

  final DeleteNextReserveDateApi deleteNextReserveDateApi;
  final UserDao userDao;

  @override
  Future<void> deleteNextReserveDate({
    required int userId,
    required int institutionId,
  }) async {
    final authenticationToken = getAuthenticationToken(userDao.get());
    await deleteNextReserveDateApi(
      authenticationToken: authenticationToken,
      userId: userId,
      institutionId: institutionId,
    );
  }
}
