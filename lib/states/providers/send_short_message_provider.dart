import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/send_short_message_api.dart';
import 'package:nomoca_flutter/data/repository/send_short_message_repository.dart';
import 'package:nomoca_flutter/states/providers/api_client_provider.dart';

class SendShortMessageStateNotifier extends StateNotifier<AsyncValue<bool>> {
  SendShortMessageStateNotifier({required this.sendShortMessageRepository})
      : super(const AsyncData(false));

  final SendShortMessageRepository sendShortMessageRepository;

  Future<void> sendShortMessage({
    required String mobilePhoneNumber,
  }) async {
    state = const AsyncLoading();
    try {
      await sendShortMessageRepository.sendShortMessage(
        mobilePhoneNumber: mobilePhoneNumber,
      );
      state = const AsyncData(true);
    } on Exception catch (error) {
      state = AsyncError(error);
    }
  }
}

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

final sendShortMessageProvider = StateNotifierProvider.autoDispose<
    SendShortMessageStateNotifier, AsyncValue<bool>>(
  (ref) => SendShortMessageStateNotifier(
    sendShortMessageRepository: ref.read(sendShortMessageRepositoryProvider),
  ),
);
