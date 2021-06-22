import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/keyword_search_api.dart';
import 'package:nomoca_flutter/data/entity/remote/keyword_search_entity.dart';
import 'package:nomoca_flutter/data/repository/keyword_search_repository.dart';
import 'package:nomoca_flutter/main.dart';
import 'package:nomoca_flutter/states/actions/keyword_search_list_action.dart';

final _keywordSearchApiProvider = Provider.autoDispose(
  (ref) => KeywordSearchApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final keywordSearchRepositoryProvider =
    Provider.autoDispose<KeywordSearchRepository>(
  (ref) => KeywordSearchRepositoryImpl(
    keywordSearchApi: ref.read(_keywordSearchApiProvider),
    userDao: ref.read(userDaoProvider),
  ),
);

// 一覧State。reducer内で一覧の状態更新が実行される。画面をまたいで利用されるのでautoDisposeしない
// stateはreducer以外からのアクセスを禁止する為private scope
final _keywordSearchListState =
    StateProvider<List<KeywordSearchEntity>>((ref) => []);

// ActionStateを更新してreducerを再実行する
final keywordSearchListActionDispatcher =
    StateProvider.autoDispose<KeywordSearchListAction>(
  (ref) =>
      const KeywordSearchListAction.fetchList(query: '', offset: 0, limit: 10),
);

final keywordSearchListReducer =
    FutureProvider.autoDispose<List<KeywordSearchEntity>>((ref) async {
  return ref.watch(keywordSearchListActionDispatcher).state.when(
    fetchList: (query, offset, limit, latitude, longitude) async {
      // API経由で一覧配列を取得
      final repository = ref.read(keywordSearchRepositoryProvider);
      final newList = await repository.fetchList(
        query: query,
        offset: offset,
        limit: limit,
        latitude: latitude,
        longitude: longitude,
      );
      // 一覧のWidgetがBuildし終わるまで待機
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        // リポジトリから取得した配列でlistStateProviderの状態を更新
        ref.read(_keywordSearchListState).state = newList;
      });
      return newList;
    },
    toggleFavorite: (institutionId) {
      // 一覧を既読状態に変更
      final currentList = ref.read(_keywordSearchListState).state;
      final newList = currentList
          .map((entity) => entity.id == institutionId
              ? entity.copyWith(isFavorite: !entity.isFavorite)
              : entity)
          .toList();
      // 一覧のWidgetがBuildし終わるまで待機
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        // 要素を追加した配列でlistStateProviderの状態を更新
        ref.read(_keywordSearchListState).state = newList;
      });
      return newList;
    },
  );
});
