import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/delete_family_user_api.dart';
import 'package:nomoca_flutter/data/repository/delete_family_user_repository.dart';
import 'package:nomoca_flutter/states/providers/api_client_provider.dart';
import 'package:nomoca_flutter/states/providers/user_dao_provider.dart';

final _deleteFamilyUserApiProvider = Provider.autoDispose(
  (ref) => DeleteFamilyUserApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final deleteFamilyUserRepositoryProvider =
    Provider.autoDispose<DeleteFamilyUserRepository>(
  (ref) => DeleteFamilyUserRepositoryImpl(
    deleteFamilyUserApi: ref.read(_deleteFamilyUserApiProvider),
    userDao: ref.read(userDaoProvider),
  ),
);

final deleteFamilyUserProvider =
    FutureProvider.autoDispose.family<void, int>((ref, familyUserId) async {
  final repository = ref.read(deleteFamilyUserRepositoryProvider);
  return repository.deleteUser(familyUserId: familyUserId);
});
