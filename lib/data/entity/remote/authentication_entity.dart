import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_entity.freezed.dart';
part 'authentication_entity.g.dart';

@freezed
class AuthenticationEntity with _$AuthenticationEntity {
  const factory AuthenticationEntity({
    @JsonKey(name: 'token') required String authenticationToken,
    @JsonKey(name: 'end_user_id') required int userId,
    @JsonKey(name: 'name') required String nickname,
  }) = _AuthenticationEntity;

  factory AuthenticationEntity.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationEntityFromJson(json);
}
