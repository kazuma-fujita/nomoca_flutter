import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/api/fetch_notification_list_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';
import 'package:nomoca_flutter/data/entity/remote/notification_entity.dart';
import 'package:nomoca_flutter/data/repository/fetch_notification_list_repository.dart';

import '../../fixture.dart';
import 'fetch_notification_list_repository_test.mocks.dart';

@GenerateMocks([FetchNotificationListApi, UserDao])
void main() {
  late MockFetchNotificationListApi _api;
  late FetchNotificationListRepository _repository;
  late MockUserDao _userDao;

  setUp(() async {
    _api = MockFetchNotificationListApi();
    _userDao = MockUserDao();
    _repository = FetchNotificationListRepositoryImpl(
        fetchNotificationListApi: _api, userDao: _userDao);
  });

  group('Testing the fetch notification list repository.', () {
    test('Testing the conversion of api responses to entities.', () async {
      // Create the stub.
      when(_userDao.get()).thenReturn(User()..authenticationToken = 'dummy');
      when(
        _api(authenticationToken: anyNamed('authenticationToken')),
      ).thenAnswer((_) async => fixture('notification_list.json'));
      // Run the test method.
      final notificationList = await _repository.fetchList();
      // Validate the result objects.
      expect(
        notificationList,
        [
          isA<NotificationEntity>()
              .having((entity) => entity.id, 'id', 23)
              .having((entity) => entity.isRead, 'isRead', false)
              .having((entity) => entity.detail.contributor, 'contributor',
                  'NOMOCaクリニックからのお知らせ')
              .having((entity) => entity.detail.deliveryDate, 'deliveryDate',
                  '2019/05/07 12:15')
              .having((entity) => entity.detail.title, 'title',
                  '定期検診の時期がやってまいりました。この機会をお見逃しなく')
              .having(
                  (entity) => entity.detail.body,
                  'body',
                  // ignore: lines_longer_than_80_chars
                  '胃カメラ（上部内視鏡）は、小さなカメラによって食道・胃のポリープやがん、炎症などを調べるのに用いられる検査機器です。\n疑わしい部分の粘膜を直接観察できるため、病変の大きさや形、色、出血の有無までがはっきりとわかります。')
              .having((entity) => entity.detail.imageUrl, 'imageUrl',
                  '/institutions/23/image1/1715503ad621053c05cbbb95719afdfc.jpg'),
          isA<NotificationEntity>()
              .having((entity) => entity.id, 'id', 251971)
              .having((entity) => entity.isRead, 'isRead', true)
              .having((entity) => entity.detail.contributor, 'contributor',
                  '香川大学前はこざき歯科医院')
              .having((entity) => entity.detail.deliveryDate, 'deliveryDate',
                  '2019/03/22 11:23')
              .having((entity) => entity.detail.title, 'title', '治療再開のご案内')
              .having(
                  (entity) => entity.detail.body,
                  'body',
                  // ignore: lines_longer_than_80_chars
                  '治療が途中のまま来院されなくなったので、心配しています。その後お変わりはありませんか？\nそのままにされていますと再度痛み出す事もありますので、早めにご都合の良い日に治療再開することをお勧めします。\nご予約のお電話をお待ちしています。')
              .having((entity) => entity.detail.imageUrl, 'imageUrl',
                  '/institutions/251971/image1/7d38138911f294749a70eda1d602355d.jpg'),
        ],
      );
      // Validate the method call.
      verify(_api(authenticationToken: anyNamed('authenticationToken')));
      verify(_userDao.get());
    });
  });

  group('Error testing of the fetch notification list repository.', () {
    test('Error testing for json conversion.', () async {
      // Create the stub.
      when(_userDao.get()).thenReturn(User()..authenticationToken = 'dummy');
      when(
        _api(
          authenticationToken: anyNamed('authenticationToken'),
        ),
      ).thenAnswer((_) async => fixture('incorrect_format.json'));
      // Run the test method.
      expect(
        () => _repository.fetchList(),
        throwsException,
      );
      // Validate the method call.
      verify(_api(authenticationToken: anyNamed('authenticationToken')));
      verify(_userDao.get());
    });
  });
}
