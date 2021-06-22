import 'package:flutter/scheduler.dart';
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

// 一覧State。reducer内で一覧の状態更新が実行される。画面をまたいで利用されるのでautoDisposeしない
final _notificationListState =
    StateProvider<List<NotificationEntity>>((ref) => []);

// ActionStateを更新してreducerを再実行する
final notificationListActionDispatcher =
    StateProvider.autoDispose<NotificationListAction>(
  (ref) => const NotificationListAction.fetchList(),
);

final notificationListReducer =
    FutureProvider.autoDispose<List<NotificationEntity>>((ref) async {
  return ref.watch(notificationListActionDispatcher).state.when(
    fetchList: () async {
      // API経由で一覧配列を取得
      final repository = ref.read(fetchNotificationListRepositoryProvider);
      final newList = await repository.fetchList();
      // リポジトリから取得した配列でlistStateProviderの状態を更新
      ref.read(_notificationListState).state = newList;
      return newList;
    },
    isRead: (notificationId) {
      // 一覧を既読状態に変更
      final currentList = ref.read(_notificationListState).state;
      final newList = currentList
          .map((entity) => entity.id == notificationId
              ? entity.copyWith(isRead: true)
              : entity)
          .toList();
      // 一覧のWidgetがBuildし終わるまで待機
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        // 要素を追加した配列でlistStateProviderの状態を更新
        ref.read(_notificationListState).state = newList;
      });
      return newList;
    },
  );
});
