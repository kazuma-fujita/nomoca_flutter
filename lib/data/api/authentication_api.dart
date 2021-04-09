import 'dart:convert';
import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';

abstract class AuthenticationApi {
  Future<void> signIn({
    required String mobilePhoneNumber,
    required String authCode,
    String? osVersion,
    String? deviceName,
  });

  Future<void> signUp({
    required String mobilePhoneNumber,
    required String nickname,
    String? osVersion,
    String? deviceName,
  });

  Future<void> sendShortMessage({
    required String mobilePhoneNumber,
  });

  Future<void> signOut();
}

class AuthenticationApiImpl implements AuthenticationApi {
  AuthenticationApiImpl({required this.apiClient});

  final ApiClient apiClient;
  static const _endPoint = '/users';

  @override
  Future<void> signIn({
    required String mobilePhoneNumber,
    required String authCode,
    String? osVersion,
    String? deviceName,
  }) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signUp({
    required String mobilePhoneNumber,
    required String nickname,
    String? osVersion,
    String? deviceName,
  }) async {
    final body = {
      'mobile_tel': mobilePhoneNumber,
      'name': nickname,
    };
    if (osVersion != null) {
      body.addAll({'os_version': osVersion});
    }
    if (deviceName != null) {
      body.addAll({'device_name': deviceName});
    }
    await apiClient.post(
      '$_endPoint/',
      headers: NomocaApiProperties.baseHeaders,
      body: json.encode(body),
    );
  }

  @override
  Future<void> sendShortMessage({required String mobilePhoneNumber}) {
    // TODO: implement sendShortMessage
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
