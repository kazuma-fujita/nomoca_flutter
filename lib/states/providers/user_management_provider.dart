import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/user_management_repository.dart';
import 'package:nomoca_flutter/states/providers/user_dao_provider.dart';

final userManagementRepositoryProvider =
    Provider.autoDispose<UserManagementRepository>((ref) =>
        UserManagementRepositoryImpl(userDao: ref.read(userDaoProvider)));

final userManagementProvider =
    FutureProvider.autoDispose<UserNicknameEntity>((ref) async {
  final repository = ref.read(userManagementRepositoryProvider);
  return repository.getUser();
});
