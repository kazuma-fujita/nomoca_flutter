// Mocks generated by Mockito 5.0.9 from annotations
// in nomoca_flutter/test/data/repository/update_user_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:nomoca_flutter/data/api/update_user_api.dart' as _i2;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [UpdateUserApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockUpdateUserApi extends _i1.Mock implements _i2.UpdateUserApi {
  MockUpdateUserApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<String> call(
          {String? authenticationToken, int? userId, String? nickname}) =>
      (super.noSuchMethod(
          Invocation.method(#call, [], {
            #authenticationToken: authenticationToken,
            #userId: userId,
            #nickname: nickname
          }),
          returnValue: Future<String>.value('')) as _i3.Future<String>);
}
