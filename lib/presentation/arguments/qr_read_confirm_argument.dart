import 'package:flutter/material.dart';
import 'package:nomoca_flutter/data/entity/remote/preview_cards_entity.dart';

@immutable
class QrReadConfirmArgument {
  const QrReadConfirmArgument({
    required this.entity,
    required this.familyUserId,
  });
  final PreviewCardsEntity entity;
  final int? familyUserId;
}
