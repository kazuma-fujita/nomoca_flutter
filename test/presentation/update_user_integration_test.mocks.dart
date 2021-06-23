// Mocks generated by Mockito 5.0.10 from annotations
// in nomoca_flutter/test/presentation/update_user_integration_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:nomoca_flutter/data/entity/database/user.dart' as _i6;
import 'package:nomoca_flutter/data/entity/remote/patient_card_entity.dart'
    as _i8;
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart'
    as _i2;
import 'package:nomoca_flutter/data/repository/patient_card_repository.dart'
    as _i7;
import 'package:nomoca_flutter/data/repository/update_user_repository.dart'
    as _i4;
import 'package:nomoca_flutter/data/repository/user_management_repository.dart'
    as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeUserNicknameEntity extends _i1.Fake
    implements _i2.UserNicknameEntity {}

/// A class which mocks [UserManagementRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserManagementRepository extends _i1.Mock
    implements _i3.UserManagementRepository {
  MockUserManagementRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.UserNicknameEntity getUser() =>
      (super.noSuchMethod(Invocation.method(#getUser, []),
          returnValue: _FakeUserNicknameEntity()) as _i2.UserNicknameEntity);
}

/// A class which mocks [UpdateUserRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUpdateUserRepository extends _i1.Mock
    implements _i4.UpdateUserRepository {
  MockUpdateUserRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.UserNicknameEntity> updateUser(
          {int? userId, String? nickname}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #updateUser, [], {#userId: userId, #nickname: nickname}),
              returnValue: Future<_i2.UserNicknameEntity>.value(
                  _FakeUserNicknameEntity()))
          as _i5.Future<_i2.UserNicknameEntity>);
  @override
  String getAuthenticationToken(_i6.User? user) =>
      (super.noSuchMethod(Invocation.method(#getAuthenticationToken, [user]),
          returnValue: '') as String);
}

/// A class which mocks [PatientCardRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockPatientCardRepository extends _i1.Mock
    implements _i7.PatientCardRepository {
  MockPatientCardRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<List<_i8.PatientCardEntity>> fetchList() =>
      (super.noSuchMethod(Invocation.method(#fetchList, []),
              returnValue: Future<List<_i8.PatientCardEntity>>.value(
                  <_i8.PatientCardEntity>[]))
          as _i5.Future<List<_i8.PatientCardEntity>>);
  @override
  String getAuthenticationToken(_i6.User? user) =>
      (super.noSuchMethod(Invocation.method(#getAuthenticationToken, [user]),
          returnValue: '') as String);
}
