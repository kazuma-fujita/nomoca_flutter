import 'package:nomoca_flutter/data/api/update_notification_token_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';
import 'package:nomoca_flutter/data/repository/authenticated.dart';

// ignore: one_member_abstracts
abstract class UpdateNotificationTokenRepository with Authenticated {
  Future<void> updateNotificationToken({required String notificationToken});
}

class UpdateNotificationTokenRepositoryImpl
    extends UpdateNotificationTokenRepository {
  UpdateNotificationTokenRepositoryImpl(
      {required this.updateNotificationTokenApi, required this.userDao});

  final UpdateNotificationTokenApi updateNotificationTokenApi;
  final UserDao userDao;

  @override
  Future<void> updateNotificationToken(
      {required String notificationToken}) async {
    // ユニークなユーザーレコード取得
    var user = userDao.get();
    try {
      if (user == null) {
        // ユーザーレコードが無ければユーザー作成
        user ??= User();
      } else {
        // ユーザーレコードがあればfcmToken更新API実行
        final authenticationToken = getAuthenticationToken(user);
        await updateNotificationTokenApi(
          authenticationToken: authenticationToken,
          notificationToken: notificationToken,
        );
      }
      // fcmToken情報をDBに新規作成/更新
      user.fcmToken = notificationToken;
      await userDao.save(user);
    } on Exception catch (error) {
      return Future.error(error);
    }
  }
}
