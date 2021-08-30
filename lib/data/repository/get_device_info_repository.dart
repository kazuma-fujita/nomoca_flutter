import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

// ignore: one_member_abstracts
abstract class GetDeviceInfoRepository {
  Future<String?> getOSVersion();
  Future<String?> getDeviceName();
}

class GetDeviceInfoRepositoryImpl extends GetDeviceInfoRepository {
  GetDeviceInfoRepositoryImpl();
  final deviceInfo = DeviceInfoPlugin();

  @override
  Future<String?> getOSVersion() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        final release = androidInfo.version.release;
        final sdkInt = androidInfo.version.sdkInt;
        return 'Android $release (SDK $sdkInt)';
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        final systemName = iosInfo.systemName;
        final version = iosInfo.systemVersion;
        return '$systemName $version';
      }
    } on PlatformException {
      return null;
    }
  }

  @override
  Future<String?> getDeviceName() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        final manufacturer = androidInfo.manufacturer;
        final model = androidInfo.model;
        return '$manufacturer $model';
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        final name = iosInfo.name;
        final model = iosInfo.model;
        return '$name $model';
      }
    } on PlatformException {
      return null;
    }
  }
}
