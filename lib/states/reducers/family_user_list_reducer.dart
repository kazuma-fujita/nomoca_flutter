import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/fetch_family_user_list_api.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/fetch_family_user_list_repository.dart';
import 'package:nomoca_flutter/main.dart';
import 'package:nomoca_flutter/states/actions/family_user_action.dart';

final fetchFamilyUserListApiProvider = Provider(
  (ref) => FetchFamilyUserListApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final fetchFamilyUserListRepositoryProvider =
    StateProvider<Future<List<UserNicknameEntity>>>(
  (ref) {
    // final repository = FetchFamilyUserListRepositoryImpl(
    //     fetchFamilyUserListApi: ref.read(fetchFamilyUserListApiProvider));
    final repository = FakeFetchFamilyUserListRepositoryImpl();
    return repository.fetchList();
  },
);

final familyUserActionProvider =
    StateProvider<FamilyUserAction>((ref) => const FamilyUserAction.fetch());

final familyUserListReducer =
    FutureProvider.autoDispose<List<UserNicknameEntity>>((ref) async {
  final action = ref.watch(familyUserActionProvider).state;
  final currentList =
      await ref.read(fetchFamilyUserListRepositoryProvider).state;
  return action.when(
    fetch: () => currentList,
    create: (user) {
      final newList = [...currentList, user];
      ref.read(fetchFamilyUserListRepositoryProvider).state =
          Future.value(newList);
      return newList;
    },
  );
});
