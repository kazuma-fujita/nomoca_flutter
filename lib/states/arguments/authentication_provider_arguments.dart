import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_provider_arguments.freezed.dart';

@freezed
class AuthenticationProviderArguments with _$AuthenticationProviderArguments {
  const factory AuthenticationProviderArguments({
    required String mobilePhoneNumber,
    required String authCode,
  }) = _AuthenticationProviderArguments;
}
