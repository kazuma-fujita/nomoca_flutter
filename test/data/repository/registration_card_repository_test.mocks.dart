// Mocks generated by Mockito 5.0.15 from annotations
// in nomoca_flutter/test/data/repository/registration_card_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:nomoca_flutter/data/api/registration_card_api.dart' as _i2;
import 'package:nomoca_flutter/data/dao/user_dao.dart' as _i4;
import 'package:nomoca_flutter/data/entity/database/user.dart' as _i5;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [RegistrationCardApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockRegistrationCardApi extends _i1.Mock
    implements _i2.RegistrationCardApi {
  MockRegistrationCardApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<void> call(
          {String? authenticationToken,
          int? sourceUserId,
          int? familyUserId}) =>
      (super.noSuchMethod(
          Invocation.method(#call, [], {
            #authenticationToken: authenticationToken,
            #sourceUserId: sourceUserId,
            #familyUserId: familyUserId
          }),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [UserDao].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserDao extends _i1.Mock implements _i4.UserDao {
  MockUserDao() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<void> save(_i5.User? user) =>
      (super.noSuchMethod(Invocation.method(#save, [user]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  String toString() => super.toString();
}
