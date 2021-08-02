import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/registration_card_api.dart';
import 'package:nomoca_flutter/data/repository/registration_card_repository.dart';
import 'package:nomoca_flutter/states/providers/api_client_provider.dart';
import 'package:nomoca_flutter/states/providers/user_dao_provider.dart';

abstract class RegistrationCardProvider
    extends StateNotifier<AsyncValue<void>> {
  RegistrationCardProvider(AsyncValue<void> state) : super(state);

  Future<void> registration({
    required int sourceUserId,
    int? familyUserId,
  });
}

class RegistrationCardProviderImpl extends StateNotifier<AsyncValue<void>>
    implements RegistrationCardProvider {
  RegistrationCardProviderImpl({required this.registrationCardRepository})
      : super(const AsyncData(null));

  final RegistrationCardRepository registrationCardRepository;

  @override
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
      state = const AsyncData(null);
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
    RegistrationCardProvider, AsyncValue<void>>(
  (ref) => RegistrationCardProviderImpl(
    registrationCardRepository: ref.read(registrationCardRepositoryProvider),
  ),
);
