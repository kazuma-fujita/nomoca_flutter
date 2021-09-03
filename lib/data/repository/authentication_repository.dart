import 'dart:convert';

import 'package:nomoca_flutter/data/api/authentication_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';
import 'package:nomoca_flutter/data/entity/remote/authentication_entity.dart';
import 'package:nomoca_flutter/data/repository/get_device_info_repository.dart';
import 'package:nomoca_flutter/errors/authentication_error.dart';

// ignore: one_member_abstracts
abstract class AuthenticationRepository {
  Future<AuthenticationEntity> authentication({
    required String mobilePhoneNumber,
    required String authCode,
  });
}

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  AuthenticationRepositoryImpl({
    required this.authenticationApi,
    required this.userDao,
    required this.deviceInfo,
  });

  final AuthenticationApi authenticationApi;
  final UserDao userDao;
  final GetDeviceInfoRepository deviceInfo;

  @override
  Future<AuthenticationEntity> authentication({
    required String mobilePhoneNumber,
    required String authCode,
  }) async {
    try {
      // final user = userDao.get();
      // // アプリインストール時に必ずfcmTokenが取得できるか、またUserObjectが生成されているか検証
      // if (user == null) {
      //   throw AuthenticationError();
      // }
      final osVersion = await deviceInfo.getOSVersion();
      final deviceName = await deviceInfo.getDeviceName();
      final responseBody = await authenticationApi(
        mobilePhoneNumber: mobilePhoneNumber,
        authCode: authCode,
        osVersion: osVersion,
        deviceName: deviceName,
      );
      final decodedJson = json.decode(responseBody) as dynamic;
      final entity =
          AuthenticationEntity.fromJson(decodedJson as Map<String, dynamic>);
      // アプリインストール時のfcmToken取得時にUserレコード作成済みを想定
      var user = userDao.get();
      // アプリインストール時にfcmTokenが取得出来なかった場合、Userレコードが存在しない可能性が有る
      // Userレコードが無い場合Userデータを新規作成するが、fcmTokenが存在しないのでPush通知は受信できない
      user ??= User();
      // 認証APIレスポンスから取得したauthenticationToken/userId/nicknameを保存
      user
        ..authenticationToken = entity.authenticationToken
        ..userId = entity.userId
        ..nickname = entity.nickname;
      // 既存Userレコードがあれば更新、無ければ新規作成
      // 正常にアプリインストール出来ていればfcmTokenが引き継がれる
      // TODO: fcmTokenが引き継がれているか確認
      await userDao.save(user);
      return entity;
    } on Exception catch (error) {
      return Future.error(error);
    }
  }
}
