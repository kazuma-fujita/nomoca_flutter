import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/fetch_favorite_list_api.dart';
import 'package:nomoca_flutter/data/api/get_favorite_patient_card_api.dart';
import 'package:nomoca_flutter/data/entity/remote/favorite_entity.dart';
import 'package:nomoca_flutter/data/entity/remote/favorite_patient_card_entity.dart';
import 'package:nomoca_flutter/data/repository/fetch_favorite_list_repository.dart';
import 'package:nomoca_flutter/data/repository/get_favorite_patient_card_repository.dart';
import 'package:nomoca_flutter/states/actions/favorite_list_action.dart';
import 'package:nomoca_flutter/states/providers/api_client_provider.dart';
import 'package:nomoca_flutter/states/providers/user_dao_provider.dart';

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

final _getFavoritePatientCardApiProvider = Provider.autoDispose(
  (ref) => GetFavoritePatientCardApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final getFavoritePatientCardRepositoryProvider =
    Provider.autoDispose<GetFavoritePatientCardRepository>(
  (ref) => GetFavoritePatientCardRepositoryImpl(
    getFavoritePatientCardApi: ref.read(_getFavoritePatientCardApiProvider),
    userDao: ref.read(userDaoProvider),
  ),
);

final getFavoritePatientCardProvider = FutureProvider.autoDispose
    .family<FavoritePatientCardEntity, Map<String, int>>((ref, ids) async {
  final repository = ref.read(getFavoritePatientCardRepositoryProvider);
  return repository.get(
      userId: ids['userId']!, institutionId: ids['institutionId']!);
});

// 一覧State。reducer内で一覧の状態更新が実行される。画面をまたいで利用されるのでautoDisposeしない
final _favoriteListListState = StateProvider<List<FavoriteEntity>>((ref) => []);

// ActionStateを更新してreducerを再実行する
final favoriteListActionDispatcher =
    StateProvider.autoDispose<FavoriteListAction>(
  (ref) => const FavoriteListAction.fetchList(),
);

final favoriteListReducer =
    FutureProvider.autoDispose<List<FavoriteEntity>>((ref) async {
  return ref.watch(favoriteListActionDispatcher).state.when(
    fetchList: () async {
      // API経由で一覧配列を取得
      final repository = ref.read(fetchFavoriteListRepositoryProvider);
      final fetchList = await repository.fetchList();
      // DEBUG
      fetchList.asMap().forEach((index, e) => print('$index:${e.name}'));
      // リポジトリから取得した配列でlistStateの状態を更新
      ref.read(_favoriteListListState).state = fetchList;
      return fetchList;
    },
  );
});
