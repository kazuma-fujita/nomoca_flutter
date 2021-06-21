import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/fetch_notification_list_api.dart';
import 'package:nomoca_flutter/data/entity/remote/notification_entity.dart';
import 'package:nomoca_flutter/data/repository/fetch_notification_list_repository.dart';
import 'package:nomoca_flutter/main.dart';
import 'package:nomoca_flutter/states/actions/notification_list_action.dart';

final _fetchNotificationListApiProvider = Provider.autoDispose(
  (ref) => FetchNotificationListApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final fetchNotificationListRepositoryProvider =
    Provider.autoDispose<FetchNotificationListRepository>(
  (ref) => FetchNotificationListRepositoryImpl(
    fetchNotificationListApi: ref.read(_fetchNotificationListApiProvider),
    userDao: ref.read(userDaoProvider),
  ),
);

// 一覧の状態保持、一覧取得を行う。reducer内で一覧の状態更新が実行される
final notificationListState =
    StateProvider.autoDispose<Future<List<NotificationEntity>>>((ref) async {
  final repository = ref.read(fetchNotificationListRepositoryProvider);
  return repository.fetchList();
});

// ActionStateを更新してreducerを再実行する
final notificationListActionDispatcher =
    StateProvider.autoDispose<NotificationListAction>(
  (ref) => const NotificationListAction.fetchList(),
);

final notificationListReducer =
    FutureProvider.autoDispose<List<NotificationEntity>>((ref) async {
  // ref.readでrepositoryProviderが保持するListの状態取得
  // ref.watchはこのreducer内でrepositoryProviderのstateを更新する度に再実行され無限ループする
  final currentList = await ref.read(notificationListState).state;
  return ref.watch(notificationListActionDispatcher).state.when(
        fetchList: () => currentList,
        isRead: (notificationId) {
          final newList = currentList
              .map((entity) => entity.id == notificationId
                  ? entity.copyWith(isRead: true)
                  : entity)
              .toList();
          // 要素を追加した配列でlistStateProviderの状態を更新
          ref.read(notificationListState).state = Future.value(newList);
          return newList;
        },
      );
});
