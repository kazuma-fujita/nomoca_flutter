import 'dart:convert';

import 'package:nomoca_flutter/constants/nomoca_urls.dart';
import 'package:nomoca_flutter/data/api/get_institution_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/remote/institution_entity.dart';
import 'package:nomoca_flutter/data/repository/authenticated.dart';

// ignore: one_member_abstracts
abstract class GetInstitutionRepository with Authenticated {
  Future<InstitutionEntity> getInstitution({required int institutionId});
}

class GetInstitutionRepositoryImpl extends GetInstitutionRepository {
  GetInstitutionRepositoryImpl(
      {required this.getInstitutionApi, required this.userDao});

  final GetInstitutionApi getInstitutionApi;
  final UserDao userDao;

  @override
  Future<InstitutionEntity> getInstitution({required int institutionId}) async {
    final authenticationToken = getAuthenticationToken(userDao.get());
    try {
      final responseBody = await getInstitutionApi(
        authenticationToken: authenticationToken,
        institutionId: institutionId,
      );

      final decodedJson = json.decode(responseBody) as dynamic;
      // Conversion json to entity.
      final entity =
          InstitutionEntity.fromJson(decodedJson as Map<String, dynamic>);
      final images = <String>[];
      if (entity.image1 != null) {
        images.add('${NomocaUrls.contentsBaseUrl}/${entity.image1}');
      }
      if (entity.image2 != null) {
        images.add('${NomocaUrls.contentsBaseUrl}/${entity.image2}');
      }
      if (entity.image3 != null) {
        images.add('${NomocaUrls.contentsBaseUrl}/${entity.image3}');
      }
      if (entity.image4 != null) {
        images.add('${NomocaUrls.contentsBaseUrl}/${entity.image4}');
      }
      if (entity.image5 != null) {
        images.add('${NomocaUrls.contentsBaseUrl}/${entity.image5}');
      }
      return entity.copyWith(
        buildingName: entity.buildingName ?? '',
        images: images,
      );
    } on Exception catch (error) {
      throw Exception(error);
    }
  }
}

class FakeGetInstitutionRepositoryImpl extends GetInstitutionRepository {
  FakeGetInstitutionRepositoryImpl();
  @override
  Future<InstitutionEntity> getInstitution({required int institutionId}) async {
    const contentsBaseUrl = 'https://contents.nomoca.com';
    return const InstitutionEntity(
      id: 92506,
      name: 'テストデンタルクリニック',
      type: 'dentistry',
      category: '歯科 / 小児歯科 / 矯正歯科',
      feature: '駅徒歩5分以内 / 保険診療 / 女性スタッフ / クレジットカード / 二ヶ国語',
      businessHour:
          '[月・火・水・金]10:00～14:00/15:00～19:00\r\n[土]10:00～14:00/15:00～17:00',
      businessHoliday: '木曜、日曜、祝日',
      address: '杉並区堀ノ内2-6-21',
      buildingName: 'パークハイム杉並C棟1F',
      access: '東京メトロ丸ノ内線 方南町駅から530m(徒歩 7分)\r\n東京メトロ丸ノ内線 東高円寺駅から1km(徒歩18分)',
      title1: '院長挨拶',
      body1: '歯科医療を通して地域医療に少しでも貢献していければ幸いです。\r\nどうぞよろしくお願いいたします。',
      title2: '診療方針',
      body2: 'テストクリニックでは、患者様一人ひとりにあった治療を行っております。\r\n患者様の立場になり、最良の治療をご提供します。',
      title3: '所属学会・研究会',
      body3: '日本接着歯学会\r\n\r\n日本口腔衛生学会\r\n\r\n日本矯正歯科学会',
      phoneNumber: '0120-811-009',
      webSiteUrl: 'https://genova.co.jp/',
      reserveUrl:
          'https://reserve.nomoca.com/reserves/new1?reserve_token=DnN8QxBGeFBC150NZqEHKq9gQqY',
      isPhoneButtonHidden: false,
      medicalDocumentUrl:
          'https://medicaldoc.jp/recommend/nishiogikubo-st-haisha/',
      longitude: 139.7241604,
      latitude: 35.6363211,
      isFavorite: false,
      images: [
        '$contentsBaseUrl/institutions/100027/image1/e907cf5540089bcdb1787a2d979e6a7b.jpg',
        '$contentsBaseUrl/institutions/100027/image4/8191a0e68a83a305c1f5c007b3ae1225.jpg',
        '$contentsBaseUrl/institutions/100027/image5/149e69d2d9726d61c98a05329e57bea6.jpg',
        '$contentsBaseUrl/institutions/100620/image5/f6d2d5248c0e35a9b094ed1c0d092102.jpg',
        '$contentsBaseUrl/institutions/102125/image3/bccffca6b7d7b44e951a0d80d6ab6586.jpg',
      ],
    );
  }
}
