import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/send_short_message_api.dart';
import 'package:nomoca_flutter/data/repository/send_short_message_repository.dart';
import 'package:nomoca_flutter/states/providers/api_client_provider.dart';

final _sendShortMessageApiProvider = Provider.autoDispose(
  (ref) => SendShortMessageApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final sendShortMessageRepositoryProvider =
    Provider.autoDispose<SendShortMessageRepository>(
  (ref) => SendShortMessageRepositoryImpl(
    sendShortMessageApi: ref.read(_sendShortMessageApiProvider),
  ),
);

final getInstitutionProvider = FutureProvider.autoDispose.family<void, String>(
  (ref, mobilePhoneNumber) async {
    return ref
        .read(sendShortMessageRepositoryProvider)
        .sendShortMessage(mobilePhoneNumber: mobilePhoneNumber);
  },
);
