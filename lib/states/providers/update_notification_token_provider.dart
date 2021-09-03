import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/update_notification_token_api.dart';
import 'package:nomoca_flutter/data/api/update_read_post_api.dart';
import 'package:nomoca_flutter/data/repository/update_notification_token_repository.dart';
import 'package:nomoca_flutter/data/repository/update_read_post_repository.dart';
import 'package:nomoca_flutter/states/providers/api_client_provider.dart';
import 'package:nomoca_flutter/states/providers/user_dao_provider.dart';

final _updateNotificationTokenApiProvider = Provider.autoDispose(
  (ref) => UpdateNotificationTokenApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final updateNotificationTokenRepositoryProvider =
    Provider.autoDispose<UpdateNotificationTokenRepository>(
  (ref) => UpdateNotificationTokenRepositoryImpl(
    updateNotificationTokenApi: ref.read(_updateNotificationTokenApiProvider),
    userDao: ref.read(userDaoProvider),
  ),
);

final updateNotificationTokenProvider =
    FutureProvider.autoDispose.family<void, String>(
  (ref, notificationToken) async {
    final repository = ref.read(updateNotificationTokenRepositoryProvider);
    return repository.updateNotificationToken(
        notificationToken: notificationToken);
  },
);
