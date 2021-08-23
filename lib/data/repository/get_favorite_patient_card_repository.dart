import 'dart:convert';

import 'package:nomoca_flutter/data/api/get_favorite_patient_card_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/remote/favorite_patient_card_entity.dart';
import 'package:nomoca_flutter/data/repository/authenticated.dart';

// ignore: one_member_abstracts
abstract class GetFavoritePatientCardRepository with Authenticated {
  Future<FavoritePatientCardEntity> get({
    required int userId,
    required int institutionId,
  });
}

class GetFavoritePatientCardRepositoryImpl
    extends GetFavoritePatientCardRepository {
  GetFavoritePatientCardRepositoryImpl(
      {required this.getFavoritePatientCardApi, required this.userDao});

  final GetFavoritePatientCardApi getFavoritePatientCardApi;
  final UserDao userDao;

  @override
  Future<FavoritePatientCardEntity> get({
    required int userId,
    required int institutionId,
  }) async {
    final authenticationToken = getAuthenticationToken(userDao.get());
    try {
      final responseBody = await getFavoritePatientCardApi(
        authenticationToken: authenticationToken,
        userId: userId,
        institutionId: institutionId,
      );

      final decodedJson = json.decode(responseBody) as dynamic;
      // Conversion json to entity.
      return FavoritePatientCardEntity.fromJson(
          decodedJson as Map<String, dynamic>);
    } on Exception catch (error) {
      throw Exception(error);
    }
  }
}
