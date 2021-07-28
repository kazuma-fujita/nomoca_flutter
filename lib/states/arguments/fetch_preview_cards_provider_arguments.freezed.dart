// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'fetch_preview_cards_provider_arguments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$FetchPreviewCardsProviderArgumentsTearOff {
  const _$FetchPreviewCardsProviderArgumentsTearOff();

  _FetchPreviewCardsProviderArguments call(
      {required String userToken, int? familyUserId}) {
    return _FetchPreviewCardsProviderArguments(
      userToken: userToken,
      familyUserId: familyUserId,
    );
  }
}

/// @nodoc
const $FetchPreviewCardsProviderArguments =
    _$FetchPreviewCardsProviderArgumentsTearOff();

/// @nodoc
mixin _$FetchPreviewCardsProviderArguments {
  String get userToken => throw _privateConstructorUsedError;
  int? get familyUserId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FetchPreviewCardsProviderArgumentsCopyWith<
          FetchPreviewCardsProviderArguments>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FetchPreviewCardsProviderArgumentsCopyWith<$Res> {
  factory $FetchPreviewCardsProviderArgumentsCopyWith(
          FetchPreviewCardsProviderArguments value,
          $Res Function(FetchPreviewCardsProviderArguments) then) =
      _$FetchPreviewCardsProviderArgumentsCopyWithImpl<$Res>;
  $Res call({String userToken, int? familyUserId});
}

/// @nodoc
class _$FetchPreviewCardsProviderArgumentsCopyWithImpl<$Res>
    implements $FetchPreviewCardsProviderArgumentsCopyWith<$Res> {
  _$FetchPreviewCardsProviderArgumentsCopyWithImpl(this._value, this._then);

  final FetchPreviewCardsProviderArguments _value;
  // ignore: unused_field
  final $Res Function(FetchPreviewCardsProviderArguments) _then;

  @override
  $Res call({
    Object? userToken = freezed,
    Object? familyUserId = freezed,
  }) {
    return _then(_value.copyWith(
      userToken: userToken == freezed
          ? _value.userToken
          : userToken // ignore: cast_nullable_to_non_nullable
              as String,
      familyUserId: familyUserId == freezed
          ? _value.familyUserId
          : familyUserId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$FetchPreviewCardsProviderArgumentsCopyWith<$Res>
    implements $FetchPreviewCardsProviderArgumentsCopyWith<$Res> {
  factory _$FetchPreviewCardsProviderArgumentsCopyWith(
          _FetchPreviewCardsProviderArguments value,
          $Res Function(_FetchPreviewCardsProviderArguments) then) =
      __$FetchPreviewCardsProviderArgumentsCopyWithImpl<$Res>;
  @override
  $Res call({String userToken, int? familyUserId});
}

/// @nodoc
class __$FetchPreviewCardsProviderArgumentsCopyWithImpl<$Res>
    extends _$FetchPreviewCardsProviderArgumentsCopyWithImpl<$Res>
    implements _$FetchPreviewCardsProviderArgumentsCopyWith<$Res> {
  __$FetchPreviewCardsProviderArgumentsCopyWithImpl(
      _FetchPreviewCardsProviderArguments _value,
      $Res Function(_FetchPreviewCardsProviderArguments) _then)
      : super(_value, (v) => _then(v as _FetchPreviewCardsProviderArguments));

  @override
  _FetchPreviewCardsProviderArguments get _value =>
      super._value as _FetchPreviewCardsProviderArguments;

  @override
  $Res call({
    Object? userToken = freezed,
    Object? familyUserId = freezed,
  }) {
    return _then(_FetchPreviewCardsProviderArguments(
      userToken: userToken == freezed
          ? _value.userToken
          : userToken // ignore: cast_nullable_to_non_nullable
              as String,
      familyUserId: familyUserId == freezed
          ? _value.familyUserId
          : familyUserId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_FetchPreviewCardsProviderArguments
    with DiagnosticableTreeMixin
    implements _FetchPreviewCardsProviderArguments {
  const _$_FetchPreviewCardsProviderArguments(
      {required this.userToken, this.familyUserId});

  @override
  final String userToken;
  @override
  final int? familyUserId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FetchPreviewCardsProviderArguments(userToken: $userToken, familyUserId: $familyUserId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FetchPreviewCardsProviderArguments'))
      ..add(DiagnosticsProperty('userToken', userToken))
      ..add(DiagnosticsProperty('familyUserId', familyUserId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FetchPreviewCardsProviderArguments &&
            (identical(other.userToken, userToken) ||
                const DeepCollectionEquality()
                    .equals(other.userToken, userToken)) &&
            (identical(other.familyUserId, familyUserId) ||
                const DeepCollectionEquality()
                    .equals(other.familyUserId, familyUserId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(userToken) ^
      const DeepCollectionEquality().hash(familyUserId);

  @JsonKey(ignore: true)
  @override
  _$FetchPreviewCardsProviderArgumentsCopyWith<
          _FetchPreviewCardsProviderArguments>
      get copyWith => __$FetchPreviewCardsProviderArgumentsCopyWithImpl<
          _FetchPreviewCardsProviderArguments>(this, _$identity);
}

abstract class _FetchPreviewCardsProviderArguments
    implements FetchPreviewCardsProviderArguments {
  const factory _FetchPreviewCardsProviderArguments(
      {required String userToken,
      int? familyUserId}) = _$_FetchPreviewCardsProviderArguments;

  @override
  String get userToken => throw _privateConstructorUsedError;
  @override
  int? get familyUserId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FetchPreviewCardsProviderArgumentsCopyWith<
          _FetchPreviewCardsProviderArguments>
      get copyWith => throw _privateConstructorUsedError;
}
