import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/authentication_api.dart';
import 'package:nomoca_flutter/data/repository/authentication_repository.dart';
import 'package:nomoca_flutter/states/providers/api_client_provider.dart';

class AuthenticationStateNotifier extends StateNotifier<AsyncValue<bool>> {
  AuthenticationStateNotifier({required this.authenticationRepository})
      : super(const AsyncData(false));

  final AuthenticationRepository authenticationRepository;

  Future<void> authentication({
    required String mobilePhoneNumber,
    required String authCode,
  }) async {
    state = const AsyncLoading();
    try {
      await authenticationRepository.authentication(
        mobilePhoneNumber: mobilePhoneNumber,
        authCode: authCode,
      );
      state = const AsyncData(true);
    } on Exception catch (error) {
      state = AsyncError(error);
    }
  }
}

final _authenticationApiProvider = Provider.autoDispose(
  (ref) => AuthenticationApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final authenticationRepositoryProvider =
    Provider.autoDispose<AuthenticationRepository>(
  (ref) => AuthenticationRepositoryImpl(
    authenticationApi: ref.read(_authenticationApiProvider),
  ),
);

final authenticationProvider = StateNotifierProvider.autoDispose<
    AuthenticationStateNotifier, AsyncValue<bool>>(
  (ref) => AuthenticationStateNotifier(
    authenticationRepository: ref.read(authenticationRepositoryProvider),
  ),
);
