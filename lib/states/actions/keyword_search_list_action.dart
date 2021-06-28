import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'keyword_search_list_action.freezed.dart';

@freezed
class KeywordSearchListAction with _$KeywordSearchListAction {
  const factory KeywordSearchListAction.fetchList({
    required String query,
    required int offset,
    required int limit,
    double? latitude,
    double? longitude,
  }) = FetchList;
  const factory KeywordSearchListAction.toggleFavorite(int institutionId) =
      ToggleFavorite;
  const factory KeywordSearchListAction.none() = None;
}
