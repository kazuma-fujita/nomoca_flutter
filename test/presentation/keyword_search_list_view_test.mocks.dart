// Mocks generated by Mockito 5.0.10 from annotations
// in nomoca_flutter/test/presentation/keyword_search_list_view_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:nomoca_flutter/data/entity/database/user.dart' as _i5;
import 'package:nomoca_flutter/data/entity/remote/keyword_search_entity.dart'
    as _i4;
import 'package:nomoca_flutter/data/repository/keyword_search_repository.dart'
    as _i2;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [KeywordSearchRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockKeywordSearchRepository extends _i1.Mock
    implements _i2.KeywordSearchRepository {
  MockKeywordSearchRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.KeywordSearchEntity>> fetchList(
          {String? query,
          int? offset,
          int? limit,
          double? latitude,
          double? longitude}) =>
      (super.noSuchMethod(
              Invocation.method(#fetchList, [], {
                #query: query,
                #offset: offset,
                #limit: limit,
                #latitude: latitude,
                #longitude: longitude
              }),
              returnValue: Future<List<_i4.KeywordSearchEntity>>.value(
                  <_i4.KeywordSearchEntity>[]))
          as _i3.Future<List<_i4.KeywordSearchEntity>>);
  @override
  String getAuthenticationToken(_i5.User? user) =>
      (super.noSuchMethod(Invocation.method(#getAuthenticationToken, [user]),
          returnValue: '') as String);
}
