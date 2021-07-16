import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/create_family_user_api.dart';
import 'package:nomoca_flutter/data/api/update_family_user_api.dart';
import 'package:nomoca_flutter/data/api/update_user_api.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/create_family_user_repository.dart';
import 'package:nomoca_flutter/data/repository/update_family_user_repository.dart';
import 'package:nomoca_flutter/data/repository/update_user_repository.dart';
import 'package:nomoca_flutter/states/providers/api_client_provider.dart';
import 'package:nomoca_flutter/states/providers/user_dao_provider.dart';

final _createFamilyUserApiProvider = Provider(
  (ref) => CreateFamilyUserApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final _updateFamilyUserApiProvider = Provider(
  (ref) => UpdateFamilyUserApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final _updateUserApiProvider = Provider(
  (ref) => UpdateUserApiImpl(
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

final updateFamilyUserRepositoryProvider =
    Provider.autoDispose<UpdateFamilyUserRepository>(
  (ref) => UpdateFamilyUserRepositoryImpl(
    updateFamilyUserApi: ref.read(_updateFamilyUserApiProvider),
    userDao: ref.read(userDaoProvider),
  ),
);

final updateUserRepositoryProvider = Provider.autoDispose<UpdateUserRepository>(
  (ref) => UpdateUserRepositoryImpl(
    updateUserApi: ref.read(_updateUserApiProvider),
    userDao: ref.read(userDaoProvider),
  ),
);

final createFamilyUserProvider = FutureProvider.autoDispose
    .family<UserNicknameEntity, String>((ref, nickname) async {
  final repository = ref.read(createFamilyUserRepositoryProvider);
  return repository.createUser(nickname: nickname);
});

final updateFamilyUserProvider = FutureProvider.autoDispose
    .family<UserNicknameEntity, UserNicknameEntity>((ref, user) async {
  final repository = ref.read(updateFamilyUserRepositoryProvider);
  return repository.updateUser(familyUserId: user.id, nickname: user.nickname);
});

final updateUserProvider = FutureProvider.autoDispose
    .family<UserNicknameEntity, UserNicknameEntity>((ref, user) async {
  final repository = ref.read(updateUserRepositoryProvider);
  return repository.updateUser(userId: user.id, nickname: user.nickname);
});
