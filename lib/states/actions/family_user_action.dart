import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';

part 'family_user_action.freezed.dart';

@freezed
abstract class FamilyUserAction with _$FamilyUserAction {
  const factory FamilyUserAction.fetch() = Fetch;
  const factory FamilyUserAction.create(UserNicknameEntity user) = Create;
  const factory FamilyUserAction.update(UserNicknameEntity user) = Update;
  const factory FamilyUserAction.delete(UserNicknameEntity user) = Delete;
}
