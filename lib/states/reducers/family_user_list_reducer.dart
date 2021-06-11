import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/fetch_family_user_list_api.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/fetch_family_user_list_repository.dart';
import 'package:nomoca_flutter/main.dart';
import 'package:nomoca_flutter/states/actions/family_user_action.dart';

// Private scope
final _fetchFamilyUserListApiProvider = Provider(
  (ref) => FetchFamilyUserListApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

// Private scope
// 家族ユーザ一覧の状態保持、一覧取得を行う。reducer内で一覧の状態更新が実行される
final _familyUserListStateProvider =
    StateProvider<Future<List<UserNicknameEntity>>>(
  (ref) {
    // final repository = FetchFamilyUserListRepositoryImpl(
    //     fetchFamilyUserListApi: ref.read(_fetchFamilyUserListApiProvider));
    final repository = FakeFetchFamilyUserListRepositoryImpl();
    return repository.fetchList();
  },
);

// Public scope
// UpsertUserViewでユーザ作成、更新時ActionStateを更新してreducerを再実行する
final familyUserActionProvider =
    StateProvider<FamilyUserAction>((ref) => const FamilyUserAction.fetch());

final familyUserListReducer =
    FutureProvider.autoDispose<List<UserNicknameEntity>>((ref) async {
  // ref.readでrepositoryProviderが保持するList<UserNicknameEntity>の状態取得
  // ref.watchはこのreducer内でrepositoryProviderのstateを更新する度に再実行され無限ループする
  final currentList = await ref.read(_familyUserListStateProvider).state;
  return ref.watch(familyUserActionProvider).state.when(
        fetch: () => currentList,
        create: (user) {
          final newList = [...currentList, user];
          // 要素を追加した配列で_familyUserListStateProviderの状態を更新
          ref.read(_familyUserListStateProvider).state = Future.value(newList);
          return newList;
        },
        update: (user) {
          final newList = currentList
              .map((item) => user.id == item.id ? user : item)
              .toList();
          // 要素を変更した配列で_familyUserListStateProviderの状態を更新
          ref.read(_familyUserListStateProvider).state = Future.value(newList);
          return newList;
        },
        delete: (user) {
          final newList =
              currentList.where((item) => user.id != item.id).toList();
          // 要素を削除した配列で_familyUserListStateProviderの状態を更新
          ref.read(_familyUserListStateProvider).state = Future.value(newList);
          return newList;
        },
      );
});
