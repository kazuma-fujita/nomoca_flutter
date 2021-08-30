import 'dart:convert';

import 'package:nomoca_flutter/data/api/authentication_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/remote/authentication_entity.dart';
import 'package:nomoca_flutter/errors/authentication_error.dart';

// ignore: one_member_abstracts
abstract class AuthenticationRepository {
  Future<AuthenticationEntity> authentication({
    required String mobilePhoneNumber,
    required String authCode,
  });
}

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  AuthenticationRepositoryImpl(
      {required this.authenticationApi, required this.userDao});

  final AuthenticationApi authenticationApi;
  final UserDao userDao;

  @override
  Future<AuthenticationEntity> authentication({
    required String mobilePhoneNumber,
    required String authCode,
  }) async {
    // TODO: 動的に値を取得
    const osVersion = '';
    const deviceName = '';
    try {
      final user = userDao.get();
      // TODO: アプリインストール時に必ずfcmTokenが取得できるか、またUserObjectが生成されているか検証
      if (user == null) {
        throw AuthenticationError();
      }
      final responseBody = await authenticationApi(
        mobilePhoneNumber: mobilePhoneNumber,
        authCode: authCode,
        osVersion: osVersion,
        deviceName: deviceName,
      );
      final decodedJson = json.decode(responseBody) as dynamic;
      // Conversion json to entity.
      final entity =
          AuthenticationEntity.fromJson(decodedJson as Map<String, dynamic>);
      // TODO: FCMTokenが引き継がれているか検証
      await userDao.save(
        user
          ..authenticationToken = entity.authenticationToken
          ..userId = entity.userId
          ..nickname = entity.nickname,
      );
      return entity;
    } on Exception catch (error) {
      return Future.error(error);
    }
  }
}
