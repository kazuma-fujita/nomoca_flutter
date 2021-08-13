import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/update_family_user_api.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/update_family_user_repository.dart';
import 'package:nomoca_flutter/states/providers/api_client_provider.dart';
import 'package:nomoca_flutter/states/providers/user_dao_provider.dart';

class UpdateFamilyUserStateNotifier
    extends StateNotifier<AsyncValue<UserNicknameEntity?>> {
  UpdateFamilyUserStateNotifier({required this.updateFamilyUserRepository})
      : super(const AsyncData(null));

  final UpdateFamilyUserRepository updateFamilyUserRepository;

  Future<void> updateUser({
    required int familyUserId,
    required String nickname,
  }) async {
    state = const AsyncLoading();
    try {
      final entity = await updateFamilyUserRepository.updateUser(
        familyUserId: familyUserId,
        nickname: nickname,
      );
      state = AsyncData(entity);
    } on Exception catch (error) {
      state = AsyncError(error);
    }
  }
}

final _updateFamilyUserApiProvider = Provider.autoDispose(
  (ref) => UpdateFamilyUserApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final updateFamilyUserRepositoryProvider =
    Provider.autoDispose<UpdateFamilyUserRepository>(
  (ref) => UpdateFamilyUserRepositoryImpl(
    updateFamilyUserApi: ref.read(_updateFamilyUserApiProvider),
    userDao: ref.read(userDaoProvider),
  ),
);

final updateFamilyUserProvider = StateNotifierProvider.autoDispose<
    UpdateFamilyUserStateNotifier, AsyncValue<UserNicknameEntity?>>(
  (ref) => UpdateFamilyUserStateNotifier(
    updateFamilyUserRepository: ref.read(updateFamilyUserRepositoryProvider),
  ),
);
