// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'authentication_provider_arguments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AuthenticationProviderArgumentsTearOff {
  const _$AuthenticationProviderArgumentsTearOff();

  _AuthenticationProviderArguments call(
      {required String mobilePhoneNumber, required String authCode}) {
    return _AuthenticationProviderArguments(
      mobilePhoneNumber: mobilePhoneNumber,
      authCode: authCode,
    );
  }
}

/// @nodoc
const $AuthenticationProviderArguments =
    _$AuthenticationProviderArgumentsTearOff();

/// @nodoc
mixin _$AuthenticationProviderArguments {
  String get mobilePhoneNumber => throw _privateConstructorUsedError;
  String get authCode => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthenticationProviderArgumentsCopyWith<AuthenticationProviderArguments>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationProviderArgumentsCopyWith<$Res> {
  factory $AuthenticationProviderArgumentsCopyWith(
          AuthenticationProviderArguments value,
          $Res Function(AuthenticationProviderArguments) then) =
      _$AuthenticationProviderArgumentsCopyWithImpl<$Res>;
  $Res call({String mobilePhoneNumber, String authCode});
}

/// @nodoc
class _$AuthenticationProviderArgumentsCopyWithImpl<$Res>
    implements $AuthenticationProviderArgumentsCopyWith<$Res> {
  _$AuthenticationProviderArgumentsCopyWithImpl(this._value, this._then);

  final AuthenticationProviderArguments _value;
  // ignore: unused_field
  final $Res Function(AuthenticationProviderArguments) _then;

  @override
  $Res call({
    Object? mobilePhoneNumber = freezed,
    Object? authCode = freezed,
  }) {
    return _then(_value.copyWith(
      mobilePhoneNumber: mobilePhoneNumber == freezed
          ? _value.mobilePhoneNumber
          : mobilePhoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      authCode: authCode == freezed
          ? _value.authCode
          : authCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$AuthenticationProviderArgumentsCopyWith<$Res>
    implements $AuthenticationProviderArgumentsCopyWith<$Res> {
  factory _$AuthenticationProviderArgumentsCopyWith(
          _AuthenticationProviderArguments value,
          $Res Function(_AuthenticationProviderArguments) then) =
      __$AuthenticationProviderArgumentsCopyWithImpl<$Res>;
  @override
  $Res call({String mobilePhoneNumber, String authCode});
}

/// @nodoc
class __$AuthenticationProviderArgumentsCopyWithImpl<$Res>
    extends _$AuthenticationProviderArgumentsCopyWithImpl<$Res>
    implements _$AuthenticationProviderArgumentsCopyWith<$Res> {
  __$AuthenticationProviderArgumentsCopyWithImpl(
      _AuthenticationProviderArguments _value,
      $Res Function(_AuthenticationProviderArguments) _then)
      : super(_value, (v) => _then(v as _AuthenticationProviderArguments));

  @override
  _AuthenticationProviderArguments get _value =>
      super._value as _AuthenticationProviderArguments;

  @override
  $Res call({
    Object? mobilePhoneNumber = freezed,
    Object? authCode = freezed,
  }) {
    return _then(_AuthenticationProviderArguments(
      mobilePhoneNumber: mobilePhoneNumber == freezed
          ? _value.mobilePhoneNumber
          : mobilePhoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      authCode: authCode == freezed
          ? _value.authCode
          : authCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_AuthenticationProviderArguments
    with DiagnosticableTreeMixin
    implements _AuthenticationProviderArguments {
  const _$_AuthenticationProviderArguments(
      {required this.mobilePhoneNumber, required this.authCode});

  @override
  final String mobilePhoneNumber;
  @override
  final String authCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthenticationProviderArguments(mobilePhoneNumber: $mobilePhoneNumber, authCode: $authCode)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthenticationProviderArguments'))
      ..add(DiagnosticsProperty('mobilePhoneNumber', mobilePhoneNumber))
      ..add(DiagnosticsProperty('authCode', authCode));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AuthenticationProviderArguments &&
            (identical(other.mobilePhoneNumber, mobilePhoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.mobilePhoneNumber, mobilePhoneNumber)) &&
            (identical(other.authCode, authCode) ||
                const DeepCollectionEquality()
                    .equals(other.authCode, authCode)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(mobilePhoneNumber) ^
      const DeepCollectionEquality().hash(authCode);

  @JsonKey(ignore: true)
  @override
  _$AuthenticationProviderArgumentsCopyWith<_AuthenticationProviderArguments>
      get copyWith => __$AuthenticationProviderArgumentsCopyWithImpl<
          _AuthenticationProviderArguments>(this, _$identity);
}

abstract class _AuthenticationProviderArguments
    implements AuthenticationProviderArguments {
  const factory _AuthenticationProviderArguments(
      {required String mobilePhoneNumber,
      required String authCode}) = _$_AuthenticationProviderArguments;

  @override
  String get mobilePhoneNumber => throw _privateConstructorUsedError;
  @override
  String get authCode => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AuthenticationProviderArgumentsCopyWith<_AuthenticationProviderArguments>
      get copyWith => throw _privateConstructorUsedError;
}
