import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_card_provider_arguments.freezed.dart';

@freezed
class RegistrationCardProviderArguments
    with _$RegistrationCardProviderArguments {
  const factory RegistrationCardProviderArguments({
    required int sourceUserId,
    int? familyUserId,
  }) = _RegistrationCardProviderArguments;
}
