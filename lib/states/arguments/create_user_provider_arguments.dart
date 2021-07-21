import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_user_provider_arguments.freezed.dart';

@freezed
abstract class CreateUserProviderArguments with _$CreateUserProviderArguments {
  const factory CreateUserProviderArguments({
    required String mobilePhoneNumber,
    required String nickname,
  }) = _CreateUserProviderArguments;
}
