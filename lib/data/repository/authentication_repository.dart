import 'dart:convert';

import 'package:nomoca_flutter/data/api/authentication_api.dart';
import 'package:nomoca_flutter/data/api/update_notification_token_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';
import 'package:nomoca_flutter/data/entity/remote/authentication_entity.dart';
import 'package:nomoca_flutter/data/repository/authenticated.dart';
import 'package:nomoca_flutter/data/repository/get_device_info_repository.dart';

// ignore: one_member_abstracts
abstract class AuthenticationRepository with Authenticated {
  Future<AuthenticationEntity> authentication({
    required String mobilePhoneNumber,
    required String authCode,
  });
}

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  AuthenticationRepositoryImpl({
    required this.authenticationApi,
    required this.updateNotificationTokenApi,
    required this.userDao,
    required this.deviceInfo,
  });

  final AuthenticationApi authenticationApi;
  final UpdateNotificationTokenApi updateNotificationTokenApi;
  final UserDao userDao;
  final GetDeviceInfoRepository deviceInfo;

  @override
  Future<AuthenticationEntity> authentication({
    required String mobilePhoneNumber,
    required String authCode,
  }) async {
    try {
      // OSVersion/deviceName取得
      final osVersion = await deviceInfo.getOSVersion();
      final deviceName = await deviceInfo.getDeviceName();
      // 認証API実行
      final responseBody = await authenticationApi(
        mobilePhoneNumber: mobilePhoneNumber,
        authCode: authCode,
        osVersion: osVersion,
        deviceName: deviceName,
      );
      // 認証API responseのjsonをentityに変換
      final decodedJson = json.decode(responseBody) as dynamic;
      final entity =
          AuthenticationEntity.fromJson(decodedJson as Map<String, dynamic>);
      // userレコード取得
      // アプリインストール時のfcmToken取得にfcmToken情報のみのUserレコードが登録されている
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
      // DB更新時fcmTokenが引き継がれる
      // TODO: fcmTokenが引き継がれているか確認
      await userDao.save(user);

      if (user.fcmToken != null) {
        print(
            'Called updating the fcm token in the authentication repository.');
        // アプリインストール時のfcmTokenが存在すればfcmToken登録API実行
        await updateNotificationTokenApi(
          authenticationToken: getAuthenticationToken(user),
          notificationToken: user.fcmToken!,
        );
      }
      return entity;
    } on Exception catch (error) {
      return Future.error(error);
    }
  }
}
