import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/fetch_family_user_list_api.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/fetch_family_user_list_repository.dart';
import 'package:nomoca_flutter/states/actions/family_user_action.dart';
import 'package:nomoca_flutter/states/providers/api_client_provider.dart';
import 'package:nomoca_flutter/states/providers/user_dao_provider.dart';

// Private scope
final _fetchFamilyUserListApiProvider = Provider.autoDispose(
  (ref) => FetchFamilyUserListApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final fetchFamilyUserListRepositoryProvider =
    Provider.autoDispose<FetchFamilyUserListRepository>(
  (ref) => FetchFamilyUserListRepositoryImpl(
    fetchFamilyUserListApi: ref.read(_fetchFamilyUserListApiProvider),
    userDao: ref.read(userDaoProvider),
  ),
);

// 家族ユーザ一覧の状態保持を行う。reducer内で一覧の状態更新が実行される
// stateはreducer以外からのアクセスを禁止する為private scope
// 画面をまたいでstateが更新されるのでautoDispose禁止
final _familyUserListState =
    StateProvider<List<UserNicknameEntity>>((ref) => []);

// UpsertUserViewでユーザ作成、更新時ActionStateを更新してreducerを再実行する
final familyUserActionDispatcher = StateProvider.autoDispose<FamilyUserAction>(
  (ref) => const FamilyUserAction.fetchList(),
);

final familyUserListReducer =
    FutureProvider.autoDispose<List<UserNicknameEntity>>((ref) async {
  return ref.watch(familyUserActionDispatcher).state.when(
    fetchList: () async {
      // リポジトリから一覧の配列を取得
      final repository = ref.read(fetchFamilyUserListRepositoryProvider);
      final newList = await repository.fetchList();
      // リポジトリから取得した配列でlistStateProviderの状態を更新
      ref.read(_familyUserListState).state = newList;
      return newList;
    },
    create: (user) {
      final currentList = ref.read(_familyUserListState).state;
      final newList = [...currentList, user];
      // 一覧のWidgetがBuildし終わるまで待機
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        // 要素を追加した配列で__familyUserListStateProviderの状態を更新
        ref.read(_familyUserListState).state = newList;
      });
      return newList;
    },
    update: (user) {
      final currentList = ref.read(_familyUserListState).state;
      final newList =
          currentList.map((item) => user.id == item.id ? user : item).toList();
      // 一覧のWidgetがBuildし終わるまで待機
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        // 要素を変更した配列で__familyUserListStateProviderの状態を更新
        ref.read(_familyUserListState).state = newList;
      });
      return newList;
    },
    delete: (user) {
      final currentList = ref.read(_familyUserListState).state;
      final newList = currentList.where((item) => user.id != item.id).toList();
      // 一覧のWidgetがBuildし終わるまで待機
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        // 要素を削除した配列で__familyUserListStateProviderの状態を更新
        ref.read(_familyUserListState).state = newList;
      });
      return newList;
    },
  );
});
