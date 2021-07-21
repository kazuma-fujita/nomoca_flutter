// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'create_user_provider_arguments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CreateUserProviderArgumentsTearOff {
  const _$CreateUserProviderArgumentsTearOff();

  _CreateUserProviderArguments call(
      {required String mobilePhoneNumber, required String nickname}) {
    return _CreateUserProviderArguments(
      mobilePhoneNumber: mobilePhoneNumber,
      nickname: nickname,
    );
  }
}

/// @nodoc
const $CreateUserProviderArguments = _$CreateUserProviderArgumentsTearOff();

/// @nodoc
mixin _$CreateUserProviderArguments {
  String get mobilePhoneNumber => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateUserProviderArgumentsCopyWith<CreateUserProviderArguments>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateUserProviderArgumentsCopyWith<$Res> {
  factory $CreateUserProviderArgumentsCopyWith(
          CreateUserProviderArguments value,
          $Res Function(CreateUserProviderArguments) then) =
      _$CreateUserProviderArgumentsCopyWithImpl<$Res>;
  $Res call({String mobilePhoneNumber, String nickname});
}

/// @nodoc
class _$CreateUserProviderArgumentsCopyWithImpl<$Res>
    implements $CreateUserProviderArgumentsCopyWith<$Res> {
  _$CreateUserProviderArgumentsCopyWithImpl(this._value, this._then);

  final CreateUserProviderArguments _value;
  // ignore: unused_field
  final $Res Function(CreateUserProviderArguments) _then;

  @override
  $Res call({
    Object? mobilePhoneNumber = freezed,
    Object? nickname = freezed,
  }) {
    return _then(_value.copyWith(
      mobilePhoneNumber: mobilePhoneNumber == freezed
          ? _value.mobilePhoneNumber
          : mobilePhoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: nickname == freezed
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$CreateUserProviderArgumentsCopyWith<$Res>
    implements $CreateUserProviderArgumentsCopyWith<$Res> {
  factory _$CreateUserProviderArgumentsCopyWith(
          _CreateUserProviderArguments value,
          $Res Function(_CreateUserProviderArguments) then) =
      __$CreateUserProviderArgumentsCopyWithImpl<$Res>;
  @override
  $Res call({String mobilePhoneNumber, String nickname});
}

/// @nodoc
class __$CreateUserProviderArgumentsCopyWithImpl<$Res>
    extends _$CreateUserProviderArgumentsCopyWithImpl<$Res>
    implements _$CreateUserProviderArgumentsCopyWith<$Res> {
  __$CreateUserProviderArgumentsCopyWithImpl(
      _CreateUserProviderArguments _value,
      $Res Function(_CreateUserProviderArguments) _then)
      : super(_value, (v) => _then(v as _CreateUserProviderArguments));

  @override
  _CreateUserProviderArguments get _value =>
      super._value as _CreateUserProviderArguments;

  @override
  $Res call({
    Object? mobilePhoneNumber = freezed,
    Object? nickname = freezed,
  }) {
    return _then(_CreateUserProviderArguments(
      mobilePhoneNumber: mobilePhoneNumber == freezed
          ? _value.mobilePhoneNumber
          : mobilePhoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: nickname == freezed
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_CreateUserProviderArguments
    with DiagnosticableTreeMixin
    implements _CreateUserProviderArguments {
  const _$_CreateUserProviderArguments(
      {required this.mobilePhoneNumber, required this.nickname});

  @override
  final String mobilePhoneNumber;
  @override
  final String nickname;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreateUserProviderArguments(mobilePhoneNumber: $mobilePhoneNumber, nickname: $nickname)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreateUserProviderArguments'))
      ..add(DiagnosticsProperty('mobilePhoneNumber', mobilePhoneNumber))
      ..add(DiagnosticsProperty('nickname', nickname));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CreateUserProviderArguments &&
            (identical(other.mobilePhoneNumber, mobilePhoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.mobilePhoneNumber, mobilePhoneNumber)) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality()
                    .equals(other.nickname, nickname)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(mobilePhoneNumber) ^
      const DeepCollectionEquality().hash(nickname);

  @JsonKey(ignore: true)
  @override
  _$CreateUserProviderArgumentsCopyWith<_CreateUserProviderArguments>
      get copyWith => __$CreateUserProviderArgumentsCopyWithImpl<
          _CreateUserProviderArguments>(this, _$identity);
}

abstract class _CreateUserProviderArguments
    implements CreateUserProviderArguments {
  const factory _CreateUserProviderArguments(
      {required String mobilePhoneNumber,
      required String nickname}) = _$_CreateUserProviderArguments;

  @override
  String get mobilePhoneNumber => throw _privateConstructorUsedError;
  @override
  String get nickname => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CreateUserProviderArgumentsCopyWith<_CreateUserProviderArguments>
      get copyWith => throw _privateConstructorUsedError;
}
