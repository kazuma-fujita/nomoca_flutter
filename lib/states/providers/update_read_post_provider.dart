import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/update_read_post_api.dart';
import 'package:nomoca_flutter/data/repository/update_read_post_repository.dart';
import 'package:nomoca_flutter/states/providers/api_client_provider.dart';
import 'package:nomoca_flutter/states/providers/user_dao_provider.dart';

final _updateReadPostApiProvider = Provider.autoDispose(
  (ref) => UpdateReadPostApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final updateReadPostRepositoryProvider =
    Provider.autoDispose<UpdateReadPostRepository>(
  (ref) => UpdateReadPostRepositoryImpl(
    updateReadPostApi: ref.read(_updateReadPostApiProvider),
    userDao: ref.read(userDaoProvider),
  ),
);

final updateReadPostProvider = FutureProvider.autoDispose.family<void, int>(
  (ref, notificationId) async {
    final repository = ref.read(updateReadPostRepositoryProvider);
    return repository.updateReadPost(notificationId: notificationId);
  },
);
