import 'package:nomoca_flutter/data/api/authentication_api.dart';
import 'package:nomoca_flutter/data/api/send_short_message_api.dart';

// ignore: one_member_abstracts
abstract class SendShortMessageRepository {
  Future<void> sendShortMessage({
    required String mobilePhoneNumber,
  });
}

class SendShortMessageRepositoryImpl extends SendShortMessageRepository {
  SendShortMessageRepositoryImpl({required this.sendShortMessageApi});

  final SendShortMessageApi sendShortMessageApi;

  @override
  Future<void> sendShortMessage({
    required String mobilePhoneNumber,
  }) async {
    await sendShortMessageApi(
      mobilePhoneNumber: mobilePhoneNumber,
    );
  }
}
