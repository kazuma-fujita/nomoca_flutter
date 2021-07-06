import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/api/fetch_favorite_list_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';
import 'package:nomoca_flutter/data/entity/remote/favorite_entity.dart';
import 'package:nomoca_flutter/data/repository/fetch_favorite_list_repository.dart';

import '../../fixture.dart';
import 'fetch_favorite_list_repository_test.mocks.dart';

@GenerateMocks([FetchFavoriteListApi, UserDao])
void main() {
  final _api = MockFetchFavoriteListApi();
  final _userDao = MockUserDao();
  final _repository = FetchFavoriteListRepositoryImpl(
    fetchFavoriteListApi: _api,
    userDao: _userDao,
  );

  tearDown(() {
    reset(_api);
    reset(_userDao);
  });

  group('Testing the fetch favorite list repository.', () {
    test('Testing the conversion of api responses to entities.', () async {
      // Create the stub.
      when(_userDao.get()).thenReturn(User()..authenticationToken = 'dummy');
      when(
        _api(authenticationToken: anyNamed('authenticationToken')),
      ).thenAnswer((_) async => fixture('favorite_list.json'));
      // Run the test method.
      final list = await _repository.fetchList();
      // Validate the result objects.
      expect(
        list,
        [
          isA<FavoriteEntity>()
              .having((entity) => entity.institutionId, 'institutionId', 92506)
              .having((entity) => entity.type, 'type', 'clinic')
              .having((entity) => entity.name, 'name', '渋谷リーフクリニック')
              .having((entity) => entity.image1, 'image1', null)
              .having((entity) => entity.image2, 'image2', null)
              .having((entity) => entity.image3, 'image3', null)
              .having((entity) => entity.image4, 'image4', null)
              .having((entity) => entity.image5, 'image5', null)
              .having((entity) => entity.images, 'images', []).having(
                  (entity) => entity.userIds, 'userIds', [199, 200, 201]),
          isA<FavoriteEntity>()
              .having((entity) => entity.institutionId, 'institutionId', 90093)
              .having((entity) => entity.type, 'type', 'dentistry')
              .having((entity) => entity.name, 'name', '小笠原歯科医院')
              .having((entity) => entity.image1, 'image1',
                  'institutions/100027/image1/e907cf5540089bcdb1787a2d979e6a7b.jpg')
              .having((entity) => entity.image2, 'image2',
                  'institutions/100027/image4/8191a0e68a83a305c1f5c007b3ae1225.jpg')
              .having((entity) => entity.image3, 'image3',
                  'institutions/100027/image5/149e69d2d9726d61c98a05329e57bea6.jpg')
              .having((entity) => entity.image4, 'image4',
                  'institutions/100620/image5/f6d2d5248c0e35a9b094ed1c0d092102.jpg')
              .having((entity) => entity.image5, 'image5',
                  'institutions/102125/image3/bccffca6b7d7b44e951a0d80d6ab6586.jpg')
              .having(
            (entity) => entity.images,
            'images',
            [
              '/institutions/100027/image1/e907cf5540089bcdb1787a2d979e6a7b.jpg',
              '/institutions/100027/image4/8191a0e68a83a305c1f5c007b3ae1225.jpg',
              '/institutions/100027/image5/149e69d2d9726d61c98a05329e57bea6.jpg',
              '/institutions/100620/image5/f6d2d5248c0e35a9b094ed1c0d092102.jpg',
              '/institutions/102125/image3/bccffca6b7d7b44e951a0d80d6ab6586.jpg',
            ],
          ).having((entity) => entity.userIds, 'userIds', [199, 200, 201]),
        ],
      );
      // Validate the method call.
      verify(_api(authenticationToken: anyNamed('authenticationToken')));
      verify(_userDao.get());
    });
  });

  group('Error testing of the fetch favorite list repository.', () {
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
        _repository.fetchList,
        throwsException,
      );
      // Validate the method call.
      verify(_api(authenticationToken: anyNamed('authenticationToken')));
      verify(_userDao.get());
    });
  });
}
