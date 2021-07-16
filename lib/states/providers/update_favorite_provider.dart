import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/update_favorite_api.dart';
import 'package:nomoca_flutter/data/repository/update_favorite_repository.dart';
import 'package:nomoca_flutter/states/providers/api_client_provider.dart';
import 'package:nomoca_flutter/states/providers/user_dao_provider.dart';

final _updateFavoriteApiProvider = Provider.autoDispose(
  (ref) => UpdateFavoriteApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final updateFavoriteRepositoryProvider =
    Provider.autoDispose<UpdateFavoriteRepository>(
  (ref) => UpdateFavoriteRepositoryImpl(
    updateFavoriteApi: ref.read(_updateFavoriteApiProvider),
    userDao: ref.read(userDaoProvider),
  ),
);

final updateFavoriteProvider = FutureProvider.autoDispose.family<void, int>(
  (ref, institutionId) async {
    final repository = ref.read(updateFavoriteRepositoryProvider);
    return repository.updateFavorite(institutionId: institutionId);
  },
);
