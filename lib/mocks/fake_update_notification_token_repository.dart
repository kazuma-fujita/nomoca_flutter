import 'package:nomoca_flutter/data/repository/update_notification_token_repository.dart';

class FakeUpdateNotificationTokenRepositoryImpl
    extends UpdateNotificationTokenRepository {
  FakeUpdateNotificationTokenRepositoryImpl();

  @override
  Future<void> updateNotificationToken(
          {required String notificationToken}) async =>
      Future.delayed(const Duration(seconds: 1), () => Future.value());
}
