import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_preview_cards_provider_arguments.freezed.dart';

@freezed
class FetchPreviewCardsProviderArguments
    with _$FetchPreviewCardsProviderArguments {
  const factory FetchPreviewCardsProviderArguments({
    required String userToken,
    int? familyUserId,
  }) = _FetchPreviewCardsProviderArguments;
}
