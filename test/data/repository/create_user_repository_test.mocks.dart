// Mocks generated by Mockito 5.0.10 from annotations
// in nomoca_flutter/test/data/repository/create_user_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:nomoca_flutter/data/api/create_user_api.dart' as _i2;
import 'package:nomoca_flutter/data/repository/get_device_info_repository.dart'
    as _i4;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [CreateUserApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockCreateUserApi extends _i1.Mock implements _i2.CreateUserApi {
  MockCreateUserApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<void> call(
          {String? mobilePhoneNumber,
          String? nickname,
          String? osVersion,
          String? deviceName}) =>
      (super.noSuchMethod(
          Invocation.method(#call, [], {
            #mobilePhoneNumber: mobilePhoneNumber,
            #nickname: nickname,
            #osVersion: osVersion,
            #deviceName: deviceName
          }),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i3.Future<void>);
}

/// A class which mocks [GetDeviceInfoRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetDeviceInfoRepository extends _i1.Mock
    implements _i4.GetDeviceInfoRepository {
  MockGetDeviceInfoRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<String?> getOSVersion() =>
      (super.noSuchMethod(Invocation.method(#getOSVersion, []),
          returnValue: Future<String?>.value()) as _i3.Future<String?>);
  @override
  _i3.Future<String?> getDeviceName() =>
      (super.noSuchMethod(Invocation.method(#getDeviceName, []),
          returnValue: Future<String?>.value()) as _i3.Future<String?>);
}
