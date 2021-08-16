import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'version_entity.freezed.dart';
part 'version_entity.g.dart';

@freezed
class VersionEntity with _$VersionEntity {
  const factory VersionEntity({
    required String version,
  }) = _VersionEntity;

  factory VersionEntity.fromJson(Map<String, dynamic> json) =>
      _$VersionEntityFromJson(json);
}
