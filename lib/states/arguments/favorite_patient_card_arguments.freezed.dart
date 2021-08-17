// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'favorite_patient_card_arguments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$FavoritePatientCardArgumentsTearOff {
  const _$FavoritePatientCardArgumentsTearOff();

  _FavoritePatientCardArguments call(
      {required int userId, required int institutionId}) {
    return _FavoritePatientCardArguments(
      userId: userId,
      institutionId: institutionId,
    );
  }
}

/// @nodoc
const $FavoritePatientCardArguments = _$FavoritePatientCardArgumentsTearOff();

/// @nodoc
mixin _$FavoritePatientCardArguments {
  int get userId => throw _privateConstructorUsedError;
  int get institutionId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FavoritePatientCardArgumentsCopyWith<FavoritePatientCardArguments>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoritePatientCardArgumentsCopyWith<$Res> {
  factory $FavoritePatientCardArgumentsCopyWith(
          FavoritePatientCardArguments value,
          $Res Function(FavoritePatientCardArguments) then) =
      _$FavoritePatientCardArgumentsCopyWithImpl<$Res>;
  $Res call({int userId, int institutionId});
}

/// @nodoc
class _$FavoritePatientCardArgumentsCopyWithImpl<$Res>
    implements $FavoritePatientCardArgumentsCopyWith<$Res> {
  _$FavoritePatientCardArgumentsCopyWithImpl(this._value, this._then);

  final FavoritePatientCardArguments _value;
  // ignore: unused_field
  final $Res Function(FavoritePatientCardArguments) _then;

  @override
  $Res call({
    Object? userId = freezed,
    Object? institutionId = freezed,
  }) {
    return _then(_value.copyWith(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      institutionId: institutionId == freezed
          ? _value.institutionId
          : institutionId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$FavoritePatientCardArgumentsCopyWith<$Res>
    implements $FavoritePatientCardArgumentsCopyWith<$Res> {
  factory _$FavoritePatientCardArgumentsCopyWith(
          _FavoritePatientCardArguments value,
          $Res Function(_FavoritePatientCardArguments) then) =
      __$FavoritePatientCardArgumentsCopyWithImpl<$Res>;
  @override
  $Res call({int userId, int institutionId});
}

/// @nodoc
class __$FavoritePatientCardArgumentsCopyWithImpl<$Res>
    extends _$FavoritePatientCardArgumentsCopyWithImpl<$Res>
    implements _$FavoritePatientCardArgumentsCopyWith<$Res> {
  __$FavoritePatientCardArgumentsCopyWithImpl(
      _FavoritePatientCardArguments _value,
      $Res Function(_FavoritePatientCardArguments) _then)
      : super(_value, (v) => _then(v as _FavoritePatientCardArguments));

  @override
  _FavoritePatientCardArguments get _value =>
      super._value as _FavoritePatientCardArguments;

  @override
  $Res call({
    Object? userId = freezed,
    Object? institutionId = freezed,
  }) {
    return _then(_FavoritePatientCardArguments(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      institutionId: institutionId == freezed
          ? _value.institutionId
          : institutionId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_FavoritePatientCardArguments
    with DiagnosticableTreeMixin
    implements _FavoritePatientCardArguments {
  const _$_FavoritePatientCardArguments(
      {required this.userId, required this.institutionId});

  @override
  final int userId;
  @override
  final int institutionId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FavoritePatientCardArguments(userId: $userId, institutionId: $institutionId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FavoritePatientCardArguments'))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('institutionId', institutionId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FavoritePatientCardArguments &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.institutionId, institutionId) ||
                const DeepCollectionEquality()
                    .equals(other.institutionId, institutionId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(institutionId);

  @JsonKey(ignore: true)
  @override
  _$FavoritePatientCardArgumentsCopyWith<_FavoritePatientCardArguments>
      get copyWith => __$FavoritePatientCardArgumentsCopyWithImpl<
          _FavoritePatientCardArguments>(this, _$identity);
}

abstract class _FavoritePatientCardArguments
    implements FavoritePatientCardArguments {
  const factory _FavoritePatientCardArguments(
      {required int userId,
      required int institutionId}) = _$_FavoritePatientCardArguments;

  @override
  int get userId => throw _privateConstructorUsedError;
  @override
  int get institutionId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FavoritePatientCardArgumentsCopyWith<_FavoritePatientCardArguments>
      get copyWith => throw _privateConstructorUsedError;
}
