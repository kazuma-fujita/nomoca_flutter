import 'package:nomoca_flutter/data/api/update_favorite_api.dart';
import 'package:nomoca_flutter/data/api/update_next_reserve_date_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/repository/authenticated.dart';
import 'package:nomoca_flutter/errors/authentication_error.dart';

// ignore: one_member_abstracts
abstract class UpdateNextReserveDateRepository with Authenticated {
  Future<void> updateNextReserveDate({
    required int userId,
    required int institutionId,
  });
}

class UpdateNextReserveDateRepositoryImpl
    extends UpdateNextReserveDateRepository {
  UpdateNextReserveDateRepositoryImpl(
      {required this.updateNextReserveDateApi, required this.userDao});

  final UpdateNextReserveDateApi updateNextReserveDateApi;
  final UserDao userDao;

  @override
  Future<void> updateNextReserveDate({
    required int userId,
    required int institutionId,
  }) async {
    final authenticationToken = getAuthenticationToken(userDao.get());
    await updateNextReserveDateApi(
      authenticationToken: authenticationToken,
      userId: userId,
      institutionId: institutionId,
    );
  }
}
