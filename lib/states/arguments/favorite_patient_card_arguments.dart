import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_patient_card_arguments.freezed.dart';

@freezed
class FavoritePatientCardArguments with _$FavoritePatientCardArguments {
  const factory FavoritePatientCardArguments({
    required int userId,
    required int institutionId,
  }) = _FavoritePatientCardArguments;
}
