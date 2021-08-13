import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/create_user_api.dart';
import 'package:nomoca_flutter/data/repository/create_user_repository.dart';
import 'package:nomoca_flutter/states/providers/api_client_provider.dart';

class CreateUserStateNotifier extends StateNotifier<AsyncValue<bool>> {
  CreateUserStateNotifier({required this.createUserRepository})
      : super(const AsyncData(false));

  final CreateUserRepository createUserRepository;

  Future<void> createUser({
    required String mobilePhoneNumber,
    required String nickname,
  }) async {
    state = const AsyncLoading();
    try {
      await createUserRepository.createUser(
        mobilePhoneNumber: mobilePhoneNumber,
        nickname: nickname,
      );
      state = const AsyncData(true);
    } on Exception catch (error) {
      state = AsyncError(error);
    }
  }
}

final _createUserApiProvider = Provider.autoDispose(
  (ref) => CreateUserApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final createUserRepositoryProvider = Provider.autoDispose<CreateUserRepository>(
  (ref) => CreateUserRepositoryImpl(
    createUserApi: ref.read(_createUserApiProvider),
  ),
);

final createUserProvider = StateNotifierProvider.autoDispose<
    CreateUserStateNotifier, AsyncValue<bool>>(
  (ref) => CreateUserStateNotifier(
    createUserRepository: ref.read(createUserRepositoryProvider),
  ),
);
