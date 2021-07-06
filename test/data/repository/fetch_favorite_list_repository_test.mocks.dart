// Mocks generated by Mockito 5.0.10 from annotations
// in nomoca_flutter/test/data/repository/fetch_favorite_list_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:nomoca_flutter/data/api/fetch_favorite_list_api.dart' as _i2;
import 'package:nomoca_flutter/data/dao/user_dao.dart' as _i4;
import 'package:nomoca_flutter/data/entity/database/user.dart' as _i5;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [FetchFavoriteListApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockFetchFavoriteListApi extends _i1.Mock
    implements _i2.FetchFavoriteListApi {
  MockFetchFavoriteListApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<String> call({String? authenticationToken}) => (super.noSuchMethod(
      Invocation.method(#call, [], {#authenticationToken: authenticationToken}),
      returnValue: Future<String>.value('')) as _i3.Future<String>);
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
          returnValueForMissingStub: Future.value()) as _i3.Future<void>);
}
