import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_list_action.freezed.dart';

@freezed
abstract class FavoriteListAction with _$FavoriteListAction {
  const factory FavoriteListAction.fetchList() = FetchList;
}
