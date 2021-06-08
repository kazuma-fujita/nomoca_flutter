import 'dart:convert';

import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/constants/nomoca_urls.dart';
import 'package:nomoca_flutter/data/api/fetch_family_user_list_api.dart';
import 'package:nomoca_flutter/data/entity/remote/patient_card_entity.dart';

// ignore: one_member_abstracts
abstract class FetchFamilyUserListRepository {
  Future<List<PatientCardEntity>> call();
}

class FetchFamilyUserListRepositoryImpl
    implements FetchFamilyUserListRepository {
  FetchFamilyUserListRepositoryImpl({required this.fetchFamilyUserListApi});

  final FetchFamilyUserListApi fetchFamilyUserListApi;

  @override
  Future<List<PatientCardEntity>> call() async {
    // TODO: DBからtoken取得
    const authenticationToken = '${NomocaApiProperties.jwtPrefix} dummy';
    try {
      final responseBody = await fetchFamilyUserListApi(
          authenticationToken: authenticationToken);

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
