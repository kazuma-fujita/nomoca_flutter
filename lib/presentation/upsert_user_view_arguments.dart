import 'package:flutter/material.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';

@immutable
class UpsertUserViewArguments {
  const UpsertUserViewArguments({
    this.isFamilyUser = false,
    this.user,
  });
  final bool isFamilyUser;
  final UserNicknameEntity? user;

  String screenTitle() =>
      '${isFamilyUser ? '家族アカウント' : 'プロフィール'}${user == null ? '作成' : '編集'}';
  String navigationPopMessage() =>
      // ignore: lines_longer_than_80_chars
      '${isFamilyUser ? '家族アカウント' : 'プロフィール'}を${user == null ? '作成' : '編集'}しました';
  String textFormFieldInitialValue() => user != null ? user!.nickname : '';
}
