import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/fetch_preview_cards_api.dart';
import 'package:nomoca_flutter/data/entity/remote/preview_cards_entity.dart';
import 'package:nomoca_flutter/data/repository/fetch_preview_cards_repository.dart';
import 'package:nomoca_flutter/states/providers/api_client_provider.dart';
import 'package:nomoca_flutter/states/providers/user_dao_provider.dart';

// abstract class FetchPreviewCardsProvider
//     extends StateNotifier<AsyncValue<PreviewCardsEntity>> {
//   FetchPreviewCardsProvider(AsyncValue<PreviewCardsEntity> state)
//       : super(state);
//
//   Future<void> fetchCards({
//     required String userToken,
//     int? familyUserId,
//   });
// }

class FetchPreviewCardsStateNotifier
    extends StateNotifier<AsyncValue<PreviewCardsEntity?>> {
  FetchPreviewCardsStateNotifier({required this.fetchPreviewCardsRepository})
      : super(const AsyncData(null));

  final FetchPreviewCardsRepository fetchPreviewCardsRepository;

  Future<void> fetchCards({
    required String userToken,
    int? familyUserId,
  }) async {
    state = const AsyncLoading();
    try {
      final entities = await fetchPreviewCardsRepository.fetchCards(
        userToken: userToken,
        familyUserId: familyUserId,
      );
      state = AsyncData(entities);
    } on Exception catch (error) {
      state = AsyncError(error);
    }
  }
}

final _fetchPreviewCardsApiProvider = Provider.autoDispose(
  (ref) => FetchPreviewCardsApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final fetchPreviewCardsRepositoryProvider =
    Provider.autoDispose<FetchPreviewCardsRepository>(
  (ref) => FetchPreviewCardsRepositoryImpl(
    fetchPreviewCardsApi: ref.read(_fetchPreviewCardsApiProvider),
    userDao: ref.read(userDaoProvider),
  ),
);

final fetchPreviewCardsProvider = StateNotifierProvider<
    FetchPreviewCardsStateNotifier, AsyncValue<PreviewCardsEntity?>>(
  (ref) => FetchPreviewCardsStateNotifier(
    fetchPreviewCardsRepository: ref.read(fetchPreviewCardsRepositoryProvider),
  ),
);
