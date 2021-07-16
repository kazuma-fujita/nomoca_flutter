import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/authentication_api.dart';
import 'package:nomoca_flutter/data/repository/authentication_repository.dart';
import 'package:nomoca_flutter/states/providers/api_client_provider.dart';

final _authenticationApiProvider = Provider.autoDispose(
  (ref) => AuthenticationApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final authenticationRepositoryProvider =
    Provider.autoDispose<AuthenticationRepository>(
  (ref) => AuthenticationRepositoryImpl(
    authenticationApi: ref.read(_authenticationApiProvider),
  ),
);

final authenticationProvider =
    FutureProvider.autoDispose.family<void, Map<String, String>>(
  (ref, args) async {
    final mobilePhoneNumber = args['mobilePhoneNumber'];
    final authCode = args['authCode'];
    if (mobilePhoneNumber == null || authCode == null) {
      throw Exception('The provider arguments is not found.');
    }
    return ref.read(authenticationRepositoryProvider).authentication(
          mobilePhoneNumber: mobilePhoneNumber,
          authCode: authCode,
        );
  },
);
