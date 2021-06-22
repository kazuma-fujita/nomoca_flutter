import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'keyword_search_entity.freezed.dart';
part 'keyword_search_entity.g.dart';

@freezed
abstract class KeywordSearchEntity with _$KeywordSearchEntity {
  const factory KeywordSearchEntity({
    required int id,
    required String name,
    required String address,
    @JsonKey(name: 'building_name') required String buildingName,
    required String image1,
    required String image2,
    required String image3,
    required String image4,
    required String image5,
    @JsonKey(name: 'is_favorite') required bool isFavorite,
  }) = _KeywordSearchEntity;

  factory KeywordSearchEntity.fromJson(Map<String, dynamic> json) =>
      _$KeywordSearchEntityFromJson(json);
}
