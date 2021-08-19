import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/update_next_reserve_date_api.dart';
import 'package:nomoca_flutter/data/repository/update_next_reserve_date_repository.dart';
import 'package:nomoca_flutter/states/providers/api_client_provider.dart';
import 'package:nomoca_flutter/states/providers/user_dao_provider.dart';

class UpdateNextReserveDateStateNotifier
    extends StateNotifier<AsyncValue<bool>> {
  UpdateNextReserveDateStateNotifier(
      {required this.updateNextReserveDateRepository})
      : super(const AsyncData(false));

  final UpdateNextReserveDateRepository updateNextReserveDateRepository;

  Future<void> updateNextReserveDate({
    required int userId,
    required int institutionId,
    required String reserveDate,
  }) async {
    state = const AsyncLoading();
    try {
      await updateNextReserveDateRepository.updateNextReserveDate(
        userId: userId,
        institutionId: institutionId,
        reserveDate: reserveDate,
      );
      state = const AsyncData(true);
    } on Exception catch (error) {
      state = AsyncError(error);
    }
  }

  void initialState() {
    state = const AsyncData(false);
  }
}

final _updateNextReserveDateApiProvider = Provider.autoDispose(
  (ref) => UpdateNextReserveDateApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final updateNextReserveDateRepositoryProvider =
    Provider.autoDispose<UpdateNextReserveDateRepository>(
  (ref) => UpdateNextReserveDateRepositoryImpl(
    updateNextReserveDateApi: ref.read(_updateNextReserveDateApiProvider),
    userDao: ref.read(userDaoProvider),
  ),
);

final updateNextReserveDateProvider = StateNotifierProvider.autoDispose<
    UpdateNextReserveDateStateNotifier, AsyncValue<bool>>(
  (ref) => UpdateNextReserveDateStateNotifier(
    updateNextReserveDateRepository:
        ref.read(updateNextReserveDateRepositoryProvider),
  ),
);
