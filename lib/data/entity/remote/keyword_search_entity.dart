import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'keyword_search_entity.freezed.dart';
part 'keyword_search_entity.g.dart';

@freezed
class KeywordSearchEntity with _$KeywordSearchEntity {
  const factory KeywordSearchEntity({
    required int id,
    required String name,
    required String address,
    @JsonKey(name: 'building_name') String? buildingName,
    String? image1,
    String? image2,
    String? image3,
    String? image4,
    String? image5,
    @JsonKey(name: 'is_favorite') required bool isFavorite,
    List<String>? images,
  }) = _KeywordSearchEntity;

  factory KeywordSearchEntity.fromJson(Map<String, dynamic> json) =>
      _$KeywordSearchEntityFromJson(json);
}
