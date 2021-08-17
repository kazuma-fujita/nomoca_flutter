import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/update_local_id_api.dart';
import 'package:nomoca_flutter/data/repository/update_local_id_repository.dart';
import 'package:nomoca_flutter/states/providers/api_client_provider.dart';
import 'package:nomoca_flutter/states/providers/user_dao_provider.dart';

class UpdateLocalIdStateNotifier extends StateNotifier<AsyncValue<bool>> {
  UpdateLocalIdStateNotifier({required this.updateLocalIdRepository})
      : super(const AsyncData(false));

  final UpdateLocalIdRepository updateLocalIdRepository;

  Future<void> updateLocalId({
    required int userId,
    required int institutionId,
    required String localId,
  }) async {
    state = const AsyncLoading();
    try {
      await updateLocalIdRepository.updateLocalId(
        userId: userId,
        institutionId: institutionId,
        localId: localId,
      );
      state = const AsyncData(true);
    } on Exception catch (error) {
      state = AsyncError(error);
    }
  }
}

final _updateLocalIdApiProvider = Provider.autoDispose(
  (ref) => UpdateLocalIdApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final updateLocalIdRepositoryProvider =
    Provider.autoDispose<UpdateLocalIdRepository>(
  (ref) => UpdateLocalIdRepositoryImpl(
    updateLocalIdApi: ref.read(_updateLocalIdApiProvider),
    userDao: ref.read(userDaoProvider),
  ),
);

final updateLocalIdProvider = StateNotifierProvider.autoDispose<
    UpdateLocalIdStateNotifier, AsyncValue<bool>>(
  (ref) => UpdateLocalIdStateNotifier(
    updateLocalIdRepository: ref.read(updateLocalIdRepositoryProvider),
  ),
);
