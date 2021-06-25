import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/constants/keyword_search_properties.dart';
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

// 検索Queryを保持するState。画面間を跨いでも検索文字列は保持される
final keywordSearchQueryState = StateProvider<String>((ref) => '');

// 一覧State。reducer内で一覧の状態更新が実行される。画面をまたいで利用されるのでautoDisposeしない
final keywordSearchListState =
    StateProvider<List<KeywordSearchEntity>>((ref) => []);

// ActionStateを更新してreducerを再実行する
final keywordSearchListActionDispatcher =
    StateProvider.autoDispose<KeywordSearchListAction>(
  // 画面初期表示する一覧のoffset/limitをfetchList Actionに設定
  (ref) => const KeywordSearchListAction.fetchList(
      query: '', offset: 0, limit: KeywordSearchProperties.limit),
);

final keywordSearchListReducer =
    FutureProvider.autoDispose<List<KeywordSearchEntity>>((ref) async {
  return ref.watch(keywordSearchListActionDispatcher).state.when(
    fetchList: (query, offset, limit, latitude, longitude) async {
      // 現在の配列を取得
      final currentList = ref.read(keywordSearchListState).state;
      // API経由で一覧配列を取得
      final repository = ref.read(keywordSearchRepositoryProvider);
      final fetchList = await repository.fetchList(
        query: query,
        offset: offset,
        limit: limit,
        latitude: latitude,
        longitude: longitude,
      );
      // DEBUG
      fetchList.asMap().forEach((index, e) => print('$index:${e.name}'));
      // offsetが0以上の場合、現在の配列にページングしたリストを追加
      final newList = offset > 0 ? [...currentList, ...fetchList] : fetchList;
      // リポジトリから取得した配列でlistStateの状態を更新
      ref.read(keywordSearchListState).state = newList;
      return newList;
    },
    toggleFavorite: (institutionId) {
      // 一覧を既読状態に変更
      final currentList = ref.read(keywordSearchListState).state;
      final newList = currentList
          .map((entity) => entity.id == institutionId
              ? entity.copyWith(isFavorite: !entity.isFavorite)
              : entity)
          .toList();
      // 一覧のWidgetがBuildし終わるまで待機
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        // 要素を追加した配列でlistStateProviderの状態を更新
        ref.read(keywordSearchListState).state = newList;
      });
      return newList;
    },
  );
});
