import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/api/update_notification_token_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';
import 'package:nomoca_flutter/data/repository/update_notification_token_repository.dart';
import 'package:nomoca_flutter/errors/authentication_error.dart';

import 'update_notification_token_repository_test.mocks.dart';

@GenerateMocks([UpdateNotificationTokenApi, UserDao])
void main() {
  final _dao = MockUserDao();
  final _api = MockUpdateNotificationTokenApi();
  final _repository = UpdateNotificationTokenRepositoryImpl(
    updateNotificationTokenApi: _api,
    userDao: _dao,
  );

  tearDown(() async {
    reset(_dao);
    reset(_api);
  });

  group('Testing the update notification token repository.', () {
    test(
        'It\'s test that not call an api when there isn\'t a user data in database.',
        () async {
      // Create the stub.
      when(_dao.get()).thenReturn(null);
      when(_dao.save(any)).thenAnswer((_) async => Future.value());
      when(_api(
        authenticationToken: anyNamed('authenticationToken'),
        notificationToken: anyNamed('notificationToken'),
      )).thenAnswer((_) async => Future.value());
      // Run the test method.
      await _repository.updateNotificationToken(notificationToken: 'fcmToken');
      // Validate the method call.
      verify(_dao.get());
      verify(_dao.save(any));
      verifyNever(_api(
        authenticationToken: anyNamed('authenticationToken'),
        notificationToken: anyNamed('notificationToken'),
      ));
    });

    test('It\'s test that call an api when there is a user data in database.',
        () async {
      // Create the stub.
      when(_dao.get()).thenReturn(User()..authenticationToken = 'authToken');
      when(_dao.save(any)).thenAnswer((_) async => Future.value());
      when(
        _api(
          authenticationToken: anyNamed('authenticationToken'),
          notificationToken: anyNamed('notificationToken'),
        ),
      ).thenAnswer((_) async => Future.value());
      // Run the test method.
      await _repository.updateNotificationToken(notificationToken: 'fcmToken');
      // Validate the method call.
      verify(_dao.get());
      verify(_dao.save(any));
      verify(_api(
        authenticationToken: 'JWT authToken',
        notificationToken: 'fcmToken',
      ));
    });
  });

  group('Error testing of the update notification token repository.', () {
    test('Verify error of authentication.', () async {
      // Create the stub.
      when(_dao.get()).thenReturn(User());
      when(_dao.save(any)).thenAnswer((_) async => Future.value());
      when(_api(
        authenticationToken: anyNamed('authenticationToken'),
        notificationToken: anyNamed('notificationToken'),
      )).thenAnswer((_) async => Future.value());
      // Run the test method.
      expect(
        _repository.updateNotificationToken(notificationToken: 'fcmToken'),
        throwsA(const TypeMatcher<AuthenticationError>()),
      );
      // Validate the method call.
      verify(_dao.get());
      verifyNever(_dao.save(any));
      verifyNever(_api(
        authenticationToken: anyNamed('authenticationToken'),
        notificationToken: anyNamed('notificationToken'),
      ));
    });
  });
}
