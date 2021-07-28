import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/registration_card_api.dart';
import 'package:nomoca_flutter/data/repository/registration_card_repository.dart';
import 'package:nomoca_flutter/states/arguments/registration_card_provider_arguments.dart';
import 'package:nomoca_flutter/states/providers/api_client_provider.dart';
import 'package:nomoca_flutter/states/providers/user_dao_provider.dart';

final _registrationCardApiProvider = Provider.autoDispose(
  (ref) => RegistrationCardApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final registrationCardRepositoryProvider =
    Provider.autoDispose<RegistrationCardRepository>(
  (ref) => RegistrationCardRepositoryImpl(
    registrationCardApi: ref.read(_registrationCardApiProvider),
    userDao: ref.read(userDaoProvider),
  ),
);

final registrationCardProvider =
    FutureProvider.autoDispose.family<void, RegistrationCardProviderArguments>(
  (ref, args) async {
    return ref.read(registrationCardRepositoryProvider).registration(
          sourceUserId: args.sourceUserId,
          familyUserId: args.familyUserId,
        );
  },
);
