import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/api/get_institution_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';
import 'package:nomoca_flutter/data/entity/remote/institution_entity.dart';
import 'package:nomoca_flutter/data/repository/get_institution_repository.dart';

import '../../fixture.dart';
import 'get_institution_repository_test.mocks.dart';

@GenerateMocks([GetInstitutionApi, UserDao])
void main() {
  final _api = MockGetInstitutionApi();
  final _userDao = MockUserDao();
  late GetInstitutionRepository _repository;

  setUp(() {
    _repository = GetInstitutionRepositoryImpl(
        getInstitutionApi: _api, userDao: _userDao);
  });

  tearDown(() {
    reset(_api);
    reset(_userDao);
  });

  group('Testing the get institution repository.', () {
    test('Testing the conversion of api responses to entities.', () async {
      // Create the stub.
      when(_userDao.get()).thenReturn(User()..authenticationToken = 'dummy');
      when(
        _api(
          authenticationToken: anyNamed('authenticationToken'),
          institutionId: anyNamed('institutionId'),
        ),
      ).thenAnswer((_) async => fixture('institution.json'));
      // Run the test method.
      final entity = await _repository.getInstitution(institutionId: 92506);
      // Validate the result objects.
      expect(
        entity,
        isA<InstitutionEntity>()
            .having((entity) => entity.id, 'id', 92506)
            .having((entity) => entity.type, 'type', 'dentistry')
            .having((entity) => entity.name, 'name', 'テストデンタルクリニック')
            .having((entity) => entity.category, 'category', '歯科 / 小児歯科 / 矯正歯科')
            .having((entity) => entity.feature, 'category',
                '駅徒歩5分以内 / 保険診療 / 女性スタッフ / クレジットカード / 二ヶ国語')
            .having((entity) => entity.businessHour, 'businessHour',
                '[月・火・水・金]10:00～14:00/15:00～19:00\r\n[土]10:00～14:00/15:00～17:00')
            .having((entity) => entity.businessHoliday, 'businessHoliday',
                '木曜、日曜、祝日')
            .having((entity) => entity.address, 'address', '杉並区堀ノ内2-6-21')
            .having(
                (entity) => entity.buildingName, 'buildingName', 'パークハイム杉並C棟1F')
            .having((entity) => entity.access, 'access',
                '東京メトロ丸ノ内線 方南町駅から530m(徒歩 7分)\r\n東京メトロ丸ノ内線 東高円寺駅から1km(徒歩18分)')
            .having((entity) => entity.title1, 'title1', '院長挨拶')
            .having((entity) => entity.body1, 'body1',
                '歯科医療を通して地域医療に少しでも貢献していければ幸いです。\r\nどうぞよろしくお願いいたします。')
            .having((entity) => entity.title2, 'title2', '診療方針')
            .having((entity) => entity.body2, 'body2',
                'テストクリニックでは、患者様一人ひとりにあった治療を行っております。\r\n患者様の立場になり、最良の治療をご提供します。')
            .having((entity) => entity.title3, 'title3', '所属学会・研究会')
            .having((entity) => entity.body3, 'body3',
                '日本接着歯学会\r\n\r\n日本口腔衛生学会\r\n\r\n日本矯正歯科学会')
            .having(
                (entity) => entity.phoneNumber, 'phoneNumber', '0120-811-009')
            .having((entity) => entity.webSiteUrl, 'webSiteUrl',
                'https://genova.co.jp/')
            .having((entity) => entity.reserveUrl, 'reserveUrl',
                'https://reserve.nomoca.com/reserves/new1?reserve_token=DnN8QxBGeFBC150NZqEHKq9gQqY')
            .having((entity) => entity.medicalDocumentUrl, 'medicalDocumentUrl',
                'https://medicaldoc.jp/recommend/nishiogikubo-st-haisha/')
            .having((entity) => entity.isPhoneButtonHidden,
                'isPhoneButtonHidden', false)
            .having((entity) => entity.longitude, 'longitude', 139.7241604)
            .having((entity) => entity.latitude, 'latitude', 35.6363211)
            .having((entity) => entity.isFavorite, 'isFavorite', true)
            .having(
          (entity) => entity.images,
          'images',
          [
            '/institutions/23/image1/1715503ad621053c05cbbb95719afdfc.jpg',
            '/institutions/23/image2/7c89c977bb8b1956338e5201362d19d4.jpg',
            '/institutions/23/image3/6d13fbf0170944945efc8a5644ebb436.jpg',
            '/institutions/23/image4/ea3d9126611628206b2532f51ac65892.jpg',
            '/institutions/23/image5/9dac3b1380d0f8812010092b20499e32.jpg',
          ],
        ),
      );
      // Validate the method call.
      verify(
        _api(
          authenticationToken: anyNamed('authenticationToken'),
          institutionId: anyNamed('institutionId'),
        ),
      );
      verify(_userDao.get());
    });
  });

  group('Error testing of the get institution repository.', () {
    test('Error testing for json conversion.', () async {
      // Create the stub.
      when(_userDao.get()).thenReturn(User()..authenticationToken = 'dummy');
      when(
        _api(
          authenticationToken: anyNamed('authenticationToken'),
          institutionId: anyNamed('institutionId'),
        ),
      ).thenAnswer((_) async => fixture('incorrect_format.json'));
      // Run the test method.
      expect(
        () => _repository.getInstitution(institutionId: 92506),
        throwsException,
      );
      // Validate the method call.
      verify(
        _api(
          authenticationToken: anyNamed('authenticationToken'),
          institutionId: anyNamed('institutionId'),
        ),
      );
      verify(_userDao.get());
    });
  });
}
