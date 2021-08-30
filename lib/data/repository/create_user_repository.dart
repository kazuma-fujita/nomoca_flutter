import 'package:nomoca_flutter/data/api/create_user_api.dart';
import 'package:nomoca_flutter/data/repository/get_device_info_repository.dart';

// ignore: one_member_abstracts
abstract class CreateUserRepository {
  Future<void> createUser({
    required String mobilePhoneNumber,
    required String nickname,
  });
}

class CreateUserRepositoryImpl extends CreateUserRepository {
  CreateUserRepositoryImpl(
      {required this.createUserApi, required this.deviceInfo});

  final CreateUserApi createUserApi;
  final GetDeviceInfoRepository deviceInfo;

  @override
  Future<void> createUser({
    required String mobilePhoneNumber,
    required String nickname,
  }) async {
    final osVersion = await deviceInfo.getOSVersion();
    final deviceName = await deviceInfo.getDeviceName();
    await createUserApi(
      mobilePhoneNumber: mobilePhoneNumber,
      nickname: nickname,
      osVersion: osVersion,
      deviceName: deviceName,
    );
  }
}
