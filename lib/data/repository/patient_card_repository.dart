import 'dart:convert';

import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/constants/nomoca_urls.dart';
import 'package:nomoca_flutter/data/api/patient_card_api.dart';
import 'package:nomoca_flutter/data/entity/remote/patient_card_entity.dart';

// ignore: one_member_abstracts
abstract class PatientCardRepository {
  Future<List<PatientCardEntity>> fetchList();
}

class PatientCardRepositoryImpl implements PatientCardRepository {
  PatientCardRepositoryImpl({required this.patientCardApi});

  final PatientCardApi patientCardApi;

  @override
  Future<List<PatientCardEntity>> fetchList() async {
    // TODO: DBからtoken取得
    const authenticationToken = '${NomocaApiProperties.jwtPrefix} dummy';
    final responseBody =
        await patientCardApi.get(authenticationToken: authenticationToken);
    try {
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
      throw Exception('Json decoding failed: $error');
    }
  }
}
