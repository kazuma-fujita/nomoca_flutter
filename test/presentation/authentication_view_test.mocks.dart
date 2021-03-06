// Mocks generated by Mockito 5.0.15 from annotations
// in nomoca_flutter/test/presentation/authentication_view_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:nomoca_flutter/data/entity/database/user.dart' as _i8;
import 'package:nomoca_flutter/data/entity/remote/authentication_entity.dart'
    as _i2;
import 'package:nomoca_flutter/data/entity/remote/patient_card_entity.dart'
    as _i7;
import 'package:nomoca_flutter/data/repository/authentication_repository.dart'
    as _i3;
import 'package:nomoca_flutter/data/repository/fetch_patient_cards_repository.dart'
    as _i6;
import 'package:nomoca_flutter/data/repository/send_short_message_repository.dart'
    as _i5;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeAuthenticationEntity_0 extends _i1.Fake
    implements _i2.AuthenticationEntity {}

/// A class which mocks [AuthenticationRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthenticationRepository extends _i1.Mock
    implements _i3.AuthenticationRepository {
  MockAuthenticationRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.AuthenticationEntity> authentication(
          {String? mobilePhoneNumber, String? authCode}) =>
      (super.noSuchMethod(
              Invocation.method(#authentication, [],
                  {#mobilePhoneNumber: mobilePhoneNumber, #authCode: authCode}),
              returnValue: Future<_i2.AuthenticationEntity>.value(
                  _FakeAuthenticationEntity_0()))
          as _i4.Future<_i2.AuthenticationEntity>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [SendShortMessageRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockSendShortMessageRepository extends _i1.Mock
    implements _i5.SendShortMessageRepository {
  MockSendShortMessageRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<void> sendShortMessage({String? mobilePhoneNumber}) =>
      (super.noSuchMethod(
          Invocation.method(
              #sendShortMessage, [], {#mobilePhoneNumber: mobilePhoneNumber}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [FetchPatientCardsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockFetchPatientCardsRepository extends _i1.Mock
    implements _i6.FetchPatientCardsRepository {
  MockFetchPatientCardsRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i7.PatientCardEntity>> fetchList() =>
      (super.noSuchMethod(Invocation.method(#fetchList, []),
              returnValue: Future<List<_i7.PatientCardEntity>>.value(
                  <_i7.PatientCardEntity>[]))
          as _i4.Future<List<_i7.PatientCardEntity>>);
  @override
  String toString() => super.toString();
  @override
  String getAuthenticationToken(_i8.User? user) =>
      (super.noSuchMethod(Invocation.method(#getAuthenticationToken, [user]),
          returnValue: '') as String);
}
