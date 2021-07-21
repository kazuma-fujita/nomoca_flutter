import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/create_user_api.dart';
import 'package:nomoca_flutter/data/repository/create_user_repository.dart';
import 'package:nomoca_flutter/states/arguments/create_user_provider_arguments.dart';
import 'package:nomoca_flutter/states/providers/api_client_provider.dart';

final _createUserApiProvider = Provider.autoDispose(
  (ref) => CreateUserApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final createUserRepositoryProvider = Provider.autoDispose<CreateUserRepository>(
  (ref) => CreateUserRepositoryImpl(
    createUserApi: ref.read(_createUserApiProvider),
  ),
);

final createUserProvider =
    FutureProvider.autoDispose.family<void, CreateUserProviderArguments>(
  (ref, args) async {
    return ref.read(createUserRepositoryProvider).createUser(
          mobilePhoneNumber: args.mobilePhoneNumber,
          nickname: args.nickname,
        );
  },
);
