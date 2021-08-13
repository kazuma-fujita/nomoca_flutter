import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/update_user_api.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/update_user_repository.dart';
import 'package:nomoca_flutter/states/providers/api_client_provider.dart';
import 'package:nomoca_flutter/states/providers/user_dao_provider.dart';

class UpdateUserStateNotifier
    extends StateNotifier<AsyncValue<UserNicknameEntity?>> {
  UpdateUserStateNotifier({required this.updateUserRepository})
      : super(const AsyncData(null));

  final UpdateUserRepository updateUserRepository;

  Future<void> updateUser({
    required int userId,
    required String nickname,
  }) async {
    state = const AsyncLoading();
    try {
      final entity = await updateUserRepository.updateUser(
        userId: userId,
        nickname: nickname,
      );
      state = AsyncData(entity);
    } on Exception catch (error) {
      state = AsyncError(error);
    }
  }
}

final _updateUserApiProvider = Provider.autoDispose(
  (ref) => UpdateUserApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final updateUserRepositoryProvider = Provider.autoDispose<UpdateUserRepository>(
  (ref) => UpdateUserRepositoryImpl(
    updateUserApi: ref.read(_updateUserApiProvider),
    userDao: ref.read(userDaoProvider),
  ),
);

final updateUserProvider = StateNotifierProvider.autoDispose<
    UpdateUserStateNotifier, AsyncValue<UserNicknameEntity?>>(
  (ref) => UpdateUserStateNotifier(
    updateUserRepository: ref.read(updateUserRepositoryProvider),
  ),
);
