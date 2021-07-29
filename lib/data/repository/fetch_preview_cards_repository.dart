import 'dart:convert';

import 'package:nomoca_flutter/data/api/fetch_preview_cards_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/remote/preview_cards_entity.dart';
import 'package:nomoca_flutter/data/repository/authenticated.dart';

// ignore: one_member_abstracts
abstract class FetchPreviewCardsRepository with Authenticated {
  Future<PreviewCardsEntity> fetchCards({
    required String userToken,
    int? familyUserId,
  });
}

class FetchPreviewCardsRepositoryImpl extends FetchPreviewCardsRepository {
  FetchPreviewCardsRepositoryImpl(
      {required this.fetchPreviewCardsApi, required this.userDao});

  final FetchPreviewCardsApi fetchPreviewCardsApi;
  final UserDao userDao;

  @override
  Future<PreviewCardsEntity> fetchCards({
    required String userToken,
    int? familyUserId,
  }) async {
    final authenticationToken = getAuthenticationToken(userDao.get());
    try {
      final responseBody = await fetchPreviewCardsApi(
        authenticationToken: authenticationToken,
        userToken: userToken,
        familyUserId: familyUserId,
      );

      final decodedJson = json.decode(responseBody) as dynamic;
      // Conversion json to entity.
      return PreviewCardsEntity.fromJson(decodedJson as Map<String, dynamic>);
    } on Exception catch (error) {
      throw Exception(error);
    }
  }
}

class FakeFetchPreviewCardsRepositoryImpl extends FetchPreviewCardsRepository {
  FakeFetchPreviewCardsRepositoryImpl();

  @override
  Future<PreviewCardsEntity> fetchCards({
    required String userToken,
    int? familyUserId,
  }) async =>
      Future.delayed(const Duration(seconds: 2), () => fakePreviewCardsEntity);
}

// main.dartでQrReadConfirmViewのモックでも使用
const fakePreviewCardsEntity = PreviewCardsEntity(sourceUserId: 123, patients: [
  PreviewCardPatientEntity(
    nameKana: 'ｻﾄｳ ﾀﾛｳ',
    localId: '12345',
    institution: PreviewCardInstitutionEntity(
      institutionId: 1234,
      institutionName: '田中歯科',
    ),
  ),
  // PreviewCardPatientEntity(
  //   nameKana: 'ｻﾄｳ ﾀﾛｳ',
  //   localId: '6789012345',
  //   institution: PreviewCardInstitutionEntity(
  //     institutionId: 5678,
  //     institutionName: '長い名前デンタルクリニック長い名前デンタルクリニック',
  //   ),
  // )
]);
