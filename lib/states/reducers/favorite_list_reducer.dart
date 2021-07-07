import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/fetch_favorite_list_api.dart';
import 'package:nomoca_flutter/data/entity/remote/favorite_entity.dart';
import 'package:nomoca_flutter/data/repository/fetch_favorite_list_repository.dart';
import 'package:nomoca_flutter/main.dart';
import 'package:nomoca_flutter/states/actions/favorite_list_action.dart';

final _fetchFavoriteListApiProvider = Provider.autoDispose(
  (ref) => FetchFavoriteListApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final fetchFavoriteListRepositoryProvider =
    Provider.autoDispose<FetchFavoriteListRepository>(
  (ref) => FetchFavoriteListRepositoryImpl(
    fetchFavoriteListApi: ref.read(_fetchFavoriteListApiProvider),
    userDao: ref.read(userDaoProvider),
  ),
);

// 一覧State。reducer内で一覧の状態更新が実行される。画面をまたいで利用されるのでautoDisposeしない
final favoriteListListState = StateProvider<List<FavoriteEntity>>((ref) => []);

// ActionStateを更新してreducerを再実行する
final favoriteListActionDispatcher =
    StateProvider.autoDispose<FavoriteListAction>(
  (ref) => const FavoriteListAction.fetchList(),
);

final favoriteListListReducer =
    FutureProvider.autoDispose<List<FavoriteEntity>>((ref) async {
  return ref.watch(favoriteListActionDispatcher).state.when(
    fetchList: () async {
      // API経由で一覧配列を取得
      final repository = ref.read(fetchFavoriteListRepositoryProvider);
      final fetchList = await repository.fetchList();
      // DEBUG
      fetchList.asMap().forEach((index, e) => print('$index:${e.name}'));
      // リポジトリから取得した配列でlistStateの状態を更新
      ref.read(favoriteListListState).state = fetchList;
      return fetchList;
    },
  );
});
