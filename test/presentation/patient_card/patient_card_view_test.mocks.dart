// Mocks generated by Mockito 5.0.9 from annotations
// in nomoca_flutter/test/presentation/patient_card/patient_card_view_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:nomoca_flutter/data/entity/remote/patient_card_entity.dart'
    as _i6;
import 'package:nomoca_flutter/presentation/patient_card/patient_card_view_model.dart'
    as _i3;
import 'package:riverpod/src/common.dart' as _i2;
import 'package:state_notifier/state_notifier.dart' as _i4;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeAsyncValue<T> extends _i1.Fake implements _i2.AsyncValue<T> {}

/// A class which mocks [PatientCardViewModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockPatientCardViewModel extends _i1.Mock
    implements _i3.PatientCardViewModel {
  MockPatientCardViewModel() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set onError(_i4.ErrorListener? _onError) =>
      super.noSuchMethod(Invocation.setter(#onError, _onError),
          returnValueForMissingStub: null);
  @override
  bool get mounted =>
      (super.noSuchMethod(Invocation.getter(#mounted), returnValue: false)
          as bool);
  @override
  _i5.Stream<_i2.AsyncValue<List<_i6.PatientCardEntity>>> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue:
                  Stream<_i2.AsyncValue<List<_i6.PatientCardEntity>>>.empty())
          as _i5.Stream<_i2.AsyncValue<List<_i6.PatientCardEntity>>>);
  @override
  _i2.AsyncValue<List<_i6.PatientCardEntity>> get state =>
      (super.noSuchMethod(Invocation.getter(#state),
              returnValue: _FakeAsyncValue<List<_i6.PatientCardEntity>>())
          as _i2.AsyncValue<List<_i6.PatientCardEntity>>);
  @override
  set state(_i2.AsyncValue<List<_i6.PatientCardEntity>>? value) =>
      super.noSuchMethod(Invocation.setter(#state, value),
          returnValueForMissingStub: null);
  @override
  _i2.AsyncValue<List<_i6.PatientCardEntity>> get debugState =>
      (super.noSuchMethod(Invocation.getter(#debugState),
              returnValue: _FakeAsyncValue<List<_i6.PatientCardEntity>>())
          as _i2.AsyncValue<List<_i6.PatientCardEntity>>);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i5.Future<void> fetchList() =>
      (super.noSuchMethod(Invocation.method(#fetchList, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i5.Future<void>);
  @override
  _i4.RemoveListener addListener(
          _i4.Listener<_i2.AsyncValue<List<_i6.PatientCardEntity>>>? listener,
          {bool? fireImmediately = true}) =>
      (super.noSuchMethod(
          Invocation.method(
              #addListener, [listener], {#fireImmediately: fireImmediately}),
          returnValue: () {}) as _i4.RemoveListener);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
}
