import 'dart:convert';

import 'package:nomoca_flutter/constants/nomoca_urls.dart';
import 'package:nomoca_flutter/data/api/patient_card_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/remote/patient_card_entity.dart';
import 'package:nomoca_flutter/data/repository/authenticated.dart';

// ignore: one_member_abstracts
abstract class PatientCardRepository with Authenticated {
  Future<List<PatientCardEntity>> fetchList();
}

class PatientCardRepositoryImpl extends PatientCardRepository {
  PatientCardRepositoryImpl(
      {required this.patientCardApi, required this.userDao});
  final PatientCardApi patientCardApi;
  final UserDao userDao;

  @override
  Future<List<PatientCardEntity>> fetchList() async {
    final user = userDao.get();
    final authenticationToken = getAuthenticationToken(user);
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
