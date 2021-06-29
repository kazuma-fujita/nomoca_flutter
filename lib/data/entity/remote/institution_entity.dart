import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'institution_entity.freezed.dart';
part 'institution_entity.g.dart';

@freezed
abstract class InstitutionEntity with _$InstitutionEntity {
  const factory InstitutionEntity({
    required int id,
    required String name,
    required String type,
    required String category,
    required String? feature,
    @JsonKey(name: 'business_hour') String? businessHour,
    @JsonKey(name: 'business_holiday') String? businessHoliday,
    required String address,
    @JsonKey(name: 'building_name') String? buildingName,
    required String? access,
    required String? title1,
    required String? body1,
    required String? title2,
    required String? body2,
    required String? title3,
    required String? body3,
    String? image1,
    String? image2,
    String? image3,
    String? image4,
    String? image5,
    @JsonKey(name: 'phone_no') required String phoneNumber,
    @JsonKey(name: 'web_site_url') String? webSiteUrl,
    @JsonKey(name: 'reserve_url') String? reserveUrl,
    @JsonKey(name: 'longitude') required double longitude,
    @JsonKey(name: 'latitude') required double latitude,
    @JsonKey(name: 'is_favorite') required bool isFavorite,
    @JsonKey(name: 'medical_document_url') String? medicalDocumentUrl,
    @JsonKey(name: 'is_phone_button_hidden') required bool isPhoneButtonHidden,
    List<String>? images,
  }) = _InstitutionEntity;

  factory InstitutionEntity.fromJson(Map<String, dynamic> json) =>
      _$InstitutionEntityFromJson(json);
}
