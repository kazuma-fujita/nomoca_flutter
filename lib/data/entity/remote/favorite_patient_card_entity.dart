import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_patient_card_entity.freezed.dart';
part 'favorite_patient_card_entity.g.dart';

@freezed
class FavoritePatientCardEntity with _$FavoritePatientCardEntity {
  const factory FavoritePatientCardEntity({
    @JsonKey(name: 'institution_id') required int institutionId,
    @JsonKey(name: 'end_user_id') required int userId,
    required String nickname,
    @JsonKey(name: 'local_id') String? localId,
    @JsonKey(name: 'reserve_at') String? reserveDate,
    @JsonKey(name: 'last_reception_at') String? lastReceptionDate,
    @JsonKey(name: 'is_patient') required bool isPatient,
  }) = _FavoritePatientCardEntity;

  factory FavoritePatientCardEntity.fromJson(Map<String, dynamic> json) =>
      _$FavoritePatientCardEntityFromJson(json);
}
