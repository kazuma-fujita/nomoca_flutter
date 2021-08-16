import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_entity.freezed.dart';
part 'favorite_entity.g.dart';

@freezed
class FavoriteEntity with _$FavoriteEntity {
  const factory FavoriteEntity({
    @JsonKey(name: 'institution_id') required int institutionId,
    required String type,
    required String name,
    String? image1,
    String? image2,
    String? image3,
    String? image4,
    String? image5,
    @JsonKey(name: 'end_user_ids') required List<int> userIds,
    List<String>? images,
  }) = _FavoriteEntity;

  factory FavoriteEntity.fromJson(Map<String, dynamic> json) =>
      _$FavoriteEntityFromJson(json);
}
