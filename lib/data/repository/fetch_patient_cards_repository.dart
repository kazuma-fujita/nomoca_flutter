import 'dart:convert';

import 'package:nomoca_flutter/constants/nomoca_urls.dart';
import 'package:nomoca_flutter/data/api/fetch_patient_cards_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/remote/patient_card_entity.dart';
import 'package:nomoca_flutter/data/repository/authenticated.dart';

// ignore: one_member_abstracts
abstract class FetchPatientCardsRepository with Authenticated {
  Future<List<PatientCardEntity>> fetchList();
}

class PatientCardRepositoryImpl extends FetchPatientCardsRepository {
  PatientCardRepositoryImpl(
      {required this.patientCardApi, required this.userDao});
  final FetchPatientCardsApi patientCardApi;
  final UserDao userDao;

  @override
  Future<List<PatientCardEntity>> fetchList() async {
    final authenticationToken = getAuthenticationToken(userDao.get());
    try {
      final responseBody =
          await patientCardApi.get(authenticationToken: authenticationToken);

      final decodedJson = json.decode(responseBody) as List<dynamic>;
      // Conversion json to entity.
      final patientCardList = decodedJson
          .map((dynamic itemJson) =>
              PatientCardEntity.fromJson(itemJson as Map<String, dynamic>))
          .toList();
      // Add contentsBaseUrl to qrCodeImageUrl.
      return patientCardList
          .map(
            (entity) => entity.copyWith(
              qrCodeImageUrl:
                  '${NomocaUrls.contentsBaseUrl}/${entity.qrCodeImageUrl}',
            ),
          )
          .toList();
    } on Exception catch (error) {
      throw Exception(error);
    }
  }
}
