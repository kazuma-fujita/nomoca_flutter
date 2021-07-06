import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/api/keyword_search_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';
import 'package:nomoca_flutter/data/entity/remote/keyword_search_entity.dart';
import 'package:nomoca_flutter/data/repository/keyword_search_repository.dart';

import '../../fixture.dart';
import 'keyword_search_repository_test.mocks.dart';

@GenerateMocks([KeywordSearchApi, UserDao])
void main() {
  final _api = MockKeywordSearchApi();
  final _userDao = MockUserDao();
  late KeywordSearchRepository _repository;

  setUp(() {
    _repository =
        KeywordSearchRepositoryImpl(keywordSearchApi: _api, userDao: _userDao);
  });

  tearDown(() {
    reset(_api);
    reset(_userDao);
  });

  group('Testing the keyword search list repository.', () {
    test('Testing the conversion of api responses to entities.', () async {
      // Create the stub.
      when(_userDao.get()).thenReturn(User()..authenticationToken = 'dummy');
      when(
        _api(
          authenticationToken: anyNamed('authenticationToken'),
          query: anyNamed('query'),
          offset: anyNamed('offset'),
          limit: anyNamed('limit'),
        ),
      ).thenAnswer((_) async => fixture('keyword_search_list_short.json'));
      // Run the test method.
      final list =
          await _repository.fetchList(query: 'dummy', offset: 0, limit: 10);
      // Validate the result objects.
      expect(
        list,
        [
          isA<KeywordSearchEntity>()
              .having((entity) => entity.id, 'id', 92506)
              .having((entity) => entity.name, 'name', '渋谷リーフクリニック')
              .having((entity) => entity.address, 'address', '渋谷区道玄坂2-23-14')
              .having((entity) => entity.buildingName, 'buildingName', '')
              .having((entity) => entity.image1, 'image1',
                  'institutions/test/image1/top1.jpg')
              .having((entity) => entity.image2, 'image2',
                  'institutions/test/image2/2.jpg')
              .having((entity) => entity.image3, 'image3', null)
              .having((entity) => entity.image4, 'image4', null)
              .having((entity) => entity.image5, 'image5', null)
              .having((entity) => entity.isFavorite, 'isFavorite', false)
              .having(
            (entity) => entity.images,
            'images',
            [
              '/institutions/test/image1/top1.jpg',
              '/institutions/test/image2/2.jpg',
            ],
          ),
          isA<KeywordSearchEntity>()
              .having((entity) => entity.id, 'id', 90093)
              .having((entity) => entity.name, 'name', '小笠原歯科')
              .having((entity) => entity.address, 'address', '渋谷区道玄坂2-25-5')
              .having((entity) => entity.buildingName, 'buildingName', '島田ビル4F')
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
              .having((entity) => entity.isFavorite, 'isFavorite', true)
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
          ),
        ],
      );
      // Validate the method call.
      verify(_api(
        authenticationToken: anyNamed('authenticationToken'),
        query: anyNamed('query'),
        offset: anyNamed('offset'),
        limit: anyNamed('limit'),
      ));
      verify(_userDao.get());
    });
  });

  group('Error testing of the keyword search list repository.', () {
    test('Error testing for json conversion.', () async {
      // Create the stub.
      when(_userDao.get()).thenReturn(User()..authenticationToken = 'dummy');
      when(
        _api(
          authenticationToken: anyNamed('authenticationToken'),
          query: anyNamed('query'),
          offset: anyNamed('offset'),
          limit: anyNamed('limit'),
        ),
      ).thenAnswer((_) async => fixture('incorrect_format.json'));
      // Run the test method.
      expect(
        () => _repository.fetchList(query: 'dummy', offset: 10, limit: 10),
        throwsException,
      );
      // Validate the method call.
      verify(_api(
        authenticationToken: anyNamed('authenticationToken'),
        query: anyNamed('query'),
        offset: anyNamed('offset'),
        limit: anyNamed('limit'),
      ));
      verify(_userDao.get());
    });
  });
}
