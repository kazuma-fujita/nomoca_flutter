import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/fetch_preview_cards_api.dart';
import 'package:nomoca_flutter/data/api/registration_card_api.dart';
import 'package:nomoca_flutter/data/entity/remote/preview_cards_entity.dart';
import 'package:nomoca_flutter/data/repository/fetch_preview_cards_repository.dart';
import 'package:nomoca_flutter/data/repository/registration_card_repository.dart';
import 'package:nomoca_flutter/states/arguments/fetch_preview_cards_provider_arguments.dart';
import 'package:nomoca_flutter/states/arguments/registration_card_provider_arguments.dart';
import 'package:nomoca_flutter/states/providers/api_client_provider.dart';
import 'package:nomoca_flutter/states/providers/user_dao_provider.dart';

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

final fetchPreviewCardsProvider = FutureProvider.autoDispose
    .family<PreviewCardsEntity, FetchPreviewCardsProviderArguments>(
  (ref, args) async {
    return ref.read(fetchPreviewCardsRepositoryProvider).fetchCards(
          userToken: args.userToken,
          familyUserId: args.familyUserId,
        );
  },
);
