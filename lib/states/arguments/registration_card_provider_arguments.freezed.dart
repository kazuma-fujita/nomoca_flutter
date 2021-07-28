// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'registration_card_provider_arguments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RegistrationCardProviderArgumentsTearOff {
  const _$RegistrationCardProviderArgumentsTearOff();

  _RegistrationCardProviderArguments call(
      {required int sourceUserId, int? familyUserId}) {
    return _RegistrationCardProviderArguments(
      sourceUserId: sourceUserId,
      familyUserId: familyUserId,
    );
  }
}

/// @nodoc
const $RegistrationCardProviderArguments =
    _$RegistrationCardProviderArgumentsTearOff();

/// @nodoc
mixin _$RegistrationCardProviderArguments {
  int get sourceUserId => throw _privateConstructorUsedError;
  int? get familyUserId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RegistrationCardProviderArgumentsCopyWith<RegistrationCardProviderArguments>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegistrationCardProviderArgumentsCopyWith<$Res> {
  factory $RegistrationCardProviderArgumentsCopyWith(
          RegistrationCardProviderArguments value,
          $Res Function(RegistrationCardProviderArguments) then) =
      _$RegistrationCardProviderArgumentsCopyWithImpl<$Res>;
  $Res call({int sourceUserId, int? familyUserId});
}

/// @nodoc
class _$RegistrationCardProviderArgumentsCopyWithImpl<$Res>
    implements $RegistrationCardProviderArgumentsCopyWith<$Res> {
  _$RegistrationCardProviderArgumentsCopyWithImpl(this._value, this._then);

  final RegistrationCardProviderArguments _value;
  // ignore: unused_field
  final $Res Function(RegistrationCardProviderArguments) _then;

  @override
  $Res call({
    Object? sourceUserId = freezed,
    Object? familyUserId = freezed,
  }) {
    return _then(_value.copyWith(
      sourceUserId: sourceUserId == freezed
          ? _value.sourceUserId
          : sourceUserId // ignore: cast_nullable_to_non_nullable
              as int,
      familyUserId: familyUserId == freezed
          ? _value.familyUserId
          : familyUserId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$RegistrationCardProviderArgumentsCopyWith<$Res>
    implements $RegistrationCardProviderArgumentsCopyWith<$Res> {
  factory _$RegistrationCardProviderArgumentsCopyWith(
          _RegistrationCardProviderArguments value,
          $Res Function(_RegistrationCardProviderArguments) then) =
      __$RegistrationCardProviderArgumentsCopyWithImpl<$Res>;
  @override
  $Res call({int sourceUserId, int? familyUserId});
}

/// @nodoc
class __$RegistrationCardProviderArgumentsCopyWithImpl<$Res>
    extends _$RegistrationCardProviderArgumentsCopyWithImpl<$Res>
    implements _$RegistrationCardProviderArgumentsCopyWith<$Res> {
  __$RegistrationCardProviderArgumentsCopyWithImpl(
      _RegistrationCardProviderArguments _value,
      $Res Function(_RegistrationCardProviderArguments) _then)
      : super(_value, (v) => _then(v as _RegistrationCardProviderArguments));

  @override
  _RegistrationCardProviderArguments get _value =>
      super._value as _RegistrationCardProviderArguments;

  @override
  $Res call({
    Object? sourceUserId = freezed,
    Object? familyUserId = freezed,
  }) {
    return _then(_RegistrationCardProviderArguments(
      sourceUserId: sourceUserId == freezed
          ? _value.sourceUserId
          : sourceUserId // ignore: cast_nullable_to_non_nullable
              as int,
      familyUserId: familyUserId == freezed
          ? _value.familyUserId
          : familyUserId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_RegistrationCardProviderArguments
    with DiagnosticableTreeMixin
    implements _RegistrationCardProviderArguments {
  const _$_RegistrationCardProviderArguments(
      {required this.sourceUserId, this.familyUserId});

  @override
  final int sourceUserId;
  @override
  final int? familyUserId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RegistrationCardProviderArguments(sourceUserId: $sourceUserId, familyUserId: $familyUserId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RegistrationCardProviderArguments'))
      ..add(DiagnosticsProperty('sourceUserId', sourceUserId))
      ..add(DiagnosticsProperty('familyUserId', familyUserId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RegistrationCardProviderArguments &&
            (identical(other.sourceUserId, sourceUserId) ||
                const DeepCollectionEquality()
                    .equals(other.sourceUserId, sourceUserId)) &&
            (identical(other.familyUserId, familyUserId) ||
                const DeepCollectionEquality()
                    .equals(other.familyUserId, familyUserId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(sourceUserId) ^
      const DeepCollectionEquality().hash(familyUserId);

  @JsonKey(ignore: true)
  @override
  _$RegistrationCardProviderArgumentsCopyWith<
          _RegistrationCardProviderArguments>
      get copyWith => __$RegistrationCardProviderArgumentsCopyWithImpl<
          _RegistrationCardProviderArguments>(this, _$identity);
}

abstract class _RegistrationCardProviderArguments
    implements RegistrationCardProviderArguments {
  const factory _RegistrationCardProviderArguments(
      {required int sourceUserId,
      int? familyUserId}) = _$_RegistrationCardProviderArguments;

  @override
  int get sourceUserId => throw _privateConstructorUsedError;
  @override
  int? get familyUserId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RegistrationCardProviderArgumentsCopyWith<
          _RegistrationCardProviderArguments>
      get copyWith => throw _privateConstructorUsedError;
}
