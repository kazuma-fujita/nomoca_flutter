// Mocks generated by Mockito 5.0.10 from annotations
// in nomoca_flutter/test/presentation/favorite_list_view_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:nomoca_flutter/data/entity/database/user.dart' as _i6;
import 'package:nomoca_flutter/data/entity/remote/favorite_entity.dart' as _i5;
import 'package:nomoca_flutter/data/entity/remote/favorite_patient_card_entity.dart'
    as _i2;
import 'package:nomoca_flutter/data/repository/fetch_favorite_list_repository.dart'
    as _i3;
import 'package:nomoca_flutter/data/repository/get_favorite_patient_card_repository.dart'
    as _i7;
import 'package:nomoca_flutter/data/repository/update_favorite_repository.dart'
    as _i8;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeFavoritePatientCardEntity extends _i1.Fake
    implements _i2.FavoritePatientCardEntity {}

/// A class which mocks [FetchFavoriteListRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockFetchFavoriteListRepository extends _i1.Mock
    implements _i3.FetchFavoriteListRepository {
  MockFetchFavoriteListRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i5.FavoriteEntity>> fetchList() => (super.noSuchMethod(
          Invocation.method(#fetchList, []),
          returnValue:
              Future<List<_i5.FavoriteEntity>>.value(<_i5.FavoriteEntity>[]))
      as _i4.Future<List<_i5.FavoriteEntity>>);
  @override
  String getAuthenticationToken(_i6.User? user) =>
      (super.noSuchMethod(Invocation.method(#getAuthenticationToken, [user]),
          returnValue: '') as String);
}

/// A class which mocks [GetFavoritePatientCardRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetFavoritePatientCardRepository extends _i1.Mock
    implements _i7.GetFavoritePatientCardRepository {
  MockGetFavoritePatientCardRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.FavoritePatientCardEntity> get(
          {int? userId, int? institutionId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #get, [], {#userId: userId, #institutionId: institutionId}),
              returnValue: Future<_i2.FavoritePatientCardEntity>.value(
                  _FakeFavoritePatientCardEntity()))
          as _i4.Future<_i2.FavoritePatientCardEntity>);
  @override
  String getAuthenticationToken(_i6.User? user) =>
      (super.noSuchMethod(Invocation.method(#getAuthenticationToken, [user]),
          returnValue: '') as String);
}

/// A class which mocks [UpdateFavoriteRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUpdateFavoriteRepository extends _i1.Mock
    implements _i8.UpdateFavoriteRepository {
  MockUpdateFavoriteRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<void> updateFavorite({int? institutionId}) => (super.noSuchMethod(
      Invocation.method(#updateFavorite, [], {#institutionId: institutionId}),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  String getAuthenticationToken(_i6.User? user) =>
      (super.noSuchMethod(Invocation.method(#getAuthenticationToken, [user]),
          returnValue: '') as String);
}
