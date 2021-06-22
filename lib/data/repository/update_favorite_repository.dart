import 'package:nomoca_flutter/data/api/update_favorite_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/repository/authenticated.dart';
import 'package:nomoca_flutter/errors/authentication_error.dart';

// ignore: one_member_abstracts
abstract class UpdateFavoriteRepository with Authenticated {
  Future<void> updateFavorite({
    required int institutionId,
  });
}

class UpdateFavoriteRepositoryImpl extends UpdateFavoriteRepository {
  UpdateFavoriteRepositoryImpl(
      {required this.updateFavoriteApi, required this.userDao});

  final UpdateFavoriteApi updateFavoriteApi;
  final UserDao userDao;

  @override
  Future<void> updateFavorite({
    required int institutionId,
  }) async {
    final user = userDao.get();
    // userIdをAPIで利用する為にuserIdのnullチェック
    if (user == null || user.userId == null) {
      throw AuthenticationError();
    }
    final authenticationToken = getAuthenticationToken(user);
    await updateFavoriteApi(
      authenticationToken: authenticationToken,
      userId: user.userId!,
      institutionId: institutionId,
    );
  }
}
