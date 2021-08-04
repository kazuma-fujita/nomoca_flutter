import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/registration_card_api.dart';
import 'package:nomoca_flutter/data/repository/registration_card_repository.dart';
import 'package:nomoca_flutter/states/providers/api_client_provider.dart';
import 'package:nomoca_flutter/states/providers/user_dao_provider.dart';

class RegistrationCardStateNotifier extends StateNotifier<AsyncValue<bool>> {
  RegistrationCardStateNotifier({required this.registrationCardRepository})
      : super(const AsyncData(false));

  final RegistrationCardRepository registrationCardRepository;

  Future<void> registration({
    required int sourceUserId,
    int? familyUserId,
  }) async {
    state = const AsyncLoading();
    try {
      await registrationCardRepository.registration(
        sourceUserId: sourceUserId,
        familyUserId: familyUserId,
      );
      state = const AsyncData(true);
    } on Exception catch (error) {
      state = AsyncError(error);
    }
  }
}

final _registrationCardApiProvider = Provider.autoDispose(
  (ref) => RegistrationCardApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final registrationCardRepositoryProvider =
    Provider.autoDispose<RegistrationCardRepository>(
  (ref) => RegistrationCardRepositoryImpl(
    registrationCardApi: ref.read(_registrationCardApiProvider),
    userDao: ref.read(userDaoProvider),
  ),
);

final registrationCardProvider = StateNotifierProvider.autoDispose<
    RegistrationCardStateNotifier, AsyncValue<bool>>(
  (ref) => RegistrationCardStateNotifier(
    registrationCardRepository: ref.read(registrationCardRepositoryProvider),
  ),
);
