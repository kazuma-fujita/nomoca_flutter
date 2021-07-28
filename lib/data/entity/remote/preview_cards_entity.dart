import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'preview_cards_entity.freezed.dart';
part 'preview_cards_entity.g.dart';

@freezed
abstract class PreviewCardsEntity with _$PreviewCardsEntity {
  const factory PreviewCardsEntity({
    @JsonKey(name: 'id') required int sourceUserId,
    @JsonKey(name: 'patients') required List<PreviewCardPatientEntity> patients,
  }) = _PreviewCardsEntity;

  factory PreviewCardsEntity.fromJson(Map<String, dynamic> json) =>
      _$PreviewCardsEntityFromJson(json);
}

@freezed
abstract class PreviewCardPatientEntity with _$PreviewCardPatientEntity {
  const factory PreviewCardPatientEntity({
    @JsonKey(name: 'name_kana') required String nameKana,
    @JsonKey(name: 'local_id') required String localId,
    @JsonKey(name: 'institution')
        required PreviewCardInstitutionEntity institution,
  }) = _PreviewCardPatientEntity;

  factory PreviewCardPatientEntity.fromJson(Map<String, dynamic> json) =>
      _$PreviewCardPatientEntityFromJson(json);
}

@freezed
abstract class PreviewCardInstitutionEntity
    with _$PreviewCardInstitutionEntity {
  const factory PreviewCardInstitutionEntity({
    @JsonKey(name: 'id') required int institutionId,
    @JsonKey(name: 'name') required String institutionName,
  }) = _PreviewCardInstitutionEntity;

  factory PreviewCardInstitutionEntity.fromJson(Map<String, dynamic> json) =>
      _$PreviewCardInstitutionEntityFromJson(json);
}
