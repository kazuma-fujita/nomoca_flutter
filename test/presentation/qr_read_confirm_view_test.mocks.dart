// Mocks generated by Mockito 5.0.15 from annotations
// in nomoca_flutter/test/presentation/qr_read_confirm_view_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:nomoca_flutter/data/entity/database/user.dart' as _i5;
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart'
    as _i2;
import 'package:nomoca_flutter/data/repository/registration_card_repository.dart'
    as _i3;
import 'package:nomoca_flutter/data/repository/user_management_repository.dart'
    as _i6;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeUserNicknameEntity_0 extends _i1.Fake
    implements _i2.UserNicknameEntity {}

/// A class which mocks [RegistrationCardRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockRegistrationCardRepository extends _i1.Mock
    implements _i3.RegistrationCardRepository {
  MockRegistrationCardRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<void> registration({int? sourceUserId, int? familyUserId}) =>
      (super.noSuchMethod(
          Invocation.method(#registration, [],
              {#sourceUserId: sourceUserId, #familyUserId: familyUserId}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  String toString() => super.toString();
  @override
  String getAuthenticationToken(_i5.User? user) =>
      (super.noSuchMethod(Invocation.method(#getAuthenticationToken, [user]),
          returnValue: '') as String);
}

/// A class which mocks [UserManagementRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserManagementRepository extends _i1.Mock
    implements _i6.UserManagementRepository {
  MockUserManagementRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.UserNicknameEntity getUser() =>
      (super.noSuchMethod(Invocation.method(#getUser, []),
          returnValue: _FakeUserNicknameEntity_0()) as _i2.UserNicknameEntity);
  @override
  String toString() => super.toString();
}
