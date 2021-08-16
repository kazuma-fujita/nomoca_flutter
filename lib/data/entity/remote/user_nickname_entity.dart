import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_nickname_entity.freezed.dart';
part 'user_nickname_entity.g.dart';

@freezed
class UserNicknameEntity with _$UserNicknameEntity {
  const factory UserNicknameEntity({
    required int id,
    @JsonKey(name: 'name') required String nickname,
  }) = _UserNicknameEntity;

  factory UserNicknameEntity.fromJson(Map<String, dynamic> json) =>
      _$UserNicknameEntityFromJson(json);
}
