import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'family_user_entity.freezed.dart';
part 'family_user_entity.g.dart';

@freezed
abstract class FamilyUserEntity with _$FamilyUserEntity {
  const factory FamilyUserEntity({
    required int id,
    @JsonKey(name: 'name') required String nickname,
  }) = _FamilyUserEntity;

  factory FamilyUserEntity.fromJson(Map<String, dynamic> json) =>
      _$FamilyUserEntityFromJson(json);
}
