import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/create_family_user_api.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/create_family_user_repository.dart';
import 'package:nomoca_flutter/states/providers/api_client_provider.dart';
import 'package:nomoca_flutter/states/providers/user_dao_provider.dart';

class CreateFamilyUserStateNotifier
    extends StateNotifier<AsyncValue<UserNicknameEntity?>> {
  CreateFamilyUserStateNotifier({required this.createFamilyUserRepository})
      : super(const AsyncData(null));

  final CreateFamilyUserRepository createFamilyUserRepository;

  Future<void> createUser({
    required String nickname,
  }) async {
    state = const AsyncLoading();
    try {
      final entity = await createFamilyUserRepository.createUser(
        nickname: nickname,
      );
      state = AsyncData(entity);
    } on Exception catch (error) {
      state = AsyncError(error);
    }
  }
}

final _createFamilyUserApiProvider = Provider.autoDispose(
  (ref) => CreateFamilyUserApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final createFamilyUserRepositoryProvider =
    Provider.autoDispose<CreateFamilyUserRepository>(
  (ref) => CreateFamilyUserRepositoryImpl(
    createFamilyUserApi: ref.read(_createFamilyUserApiProvider),
    userDao: ref.read(userDaoProvider),
  ),
);

final createFamilyUserProvider = StateNotifierProvider.autoDispose<
    CreateFamilyUserStateNotifier, AsyncValue<UserNicknameEntity?>>(
  (ref) => CreateFamilyUserStateNotifier(
    createFamilyUserRepository: ref.read(createFamilyUserRepositoryProvider),
  ),
);
