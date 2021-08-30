// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'authentication_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AuthenticationEntity _$AuthenticationEntityFromJson(Map<String, dynamic> json) {
  return _AuthenticationEntity.fromJson(json);
}

/// @nodoc
class _$AuthenticationEntityTearOff {
  const _$AuthenticationEntityTearOff();

  _AuthenticationEntity call(
      {@JsonKey(name: 'token') required String authenticationToken,
      @JsonKey(name: 'end_user_id') required int userId,
      @JsonKey(name: 'name') required String nickname}) {
    return _AuthenticationEntity(
      authenticationToken: authenticationToken,
      userId: userId,
      nickname: nickname,
    );
  }

  AuthenticationEntity fromJson(Map<String, Object> json) {
    return AuthenticationEntity.fromJson(json);
  }
}

/// @nodoc
const $AuthenticationEntity = _$AuthenticationEntityTearOff();

/// @nodoc
mixin _$AuthenticationEntity {
  @JsonKey(name: 'token')
  String get authenticationToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_user_id')
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get nickname => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthenticationEntityCopyWith<AuthenticationEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationEntityCopyWith<$Res> {
  factory $AuthenticationEntityCopyWith(AuthenticationEntity value,
          $Res Function(AuthenticationEntity) then) =
      _$AuthenticationEntityCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'token') String authenticationToken,
      @JsonKey(name: 'end_user_id') int userId,
      @JsonKey(name: 'name') String nickname});
}

/// @nodoc
class _$AuthenticationEntityCopyWithImpl<$Res>
    implements $AuthenticationEntityCopyWith<$Res> {
  _$AuthenticationEntityCopyWithImpl(this._value, this._then);

  final AuthenticationEntity _value;
  // ignore: unused_field
  final $Res Function(AuthenticationEntity) _then;

  @override
  $Res call({
    Object? authenticationToken = freezed,
    Object? userId = freezed,
    Object? nickname = freezed,
  }) {
    return _then(_value.copyWith(
      authenticationToken: authenticationToken == freezed
          ? _value.authenticationToken
          : authenticationToken // ignore: cast_nullable_to_non_nullable
              as String,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: nickname == freezed
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$AuthenticationEntityCopyWith<$Res>
    implements $AuthenticationEntityCopyWith<$Res> {
  factory _$AuthenticationEntityCopyWith(_AuthenticationEntity value,
          $Res Function(_AuthenticationEntity) then) =
      __$AuthenticationEntityCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'token') String authenticationToken,
      @JsonKey(name: 'end_user_id') int userId,
      @JsonKey(name: 'name') String nickname});
}

/// @nodoc
class __$AuthenticationEntityCopyWithImpl<$Res>
    extends _$AuthenticationEntityCopyWithImpl<$Res>
    implements _$AuthenticationEntityCopyWith<$Res> {
  __$AuthenticationEntityCopyWithImpl(
      _AuthenticationEntity _value, $Res Function(_AuthenticationEntity) _then)
      : super(_value, (v) => _then(v as _AuthenticationEntity));

  @override
  _AuthenticationEntity get _value => super._value as _AuthenticationEntity;

  @override
  $Res call({
    Object? authenticationToken = freezed,
    Object? userId = freezed,
    Object? nickname = freezed,
  }) {
    return _then(_AuthenticationEntity(
      authenticationToken: authenticationToken == freezed
          ? _value.authenticationToken
          : authenticationToken // ignore: cast_nullable_to_non_nullable
              as String,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: nickname == freezed
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AuthenticationEntity
    with DiagnosticableTreeMixin
    implements _AuthenticationEntity {
  const _$_AuthenticationEntity(
      {@JsonKey(name: 'token') required this.authenticationToken,
      @JsonKey(name: 'end_user_id') required this.userId,
      @JsonKey(name: 'name') required this.nickname});

  factory _$_AuthenticationEntity.fromJson(Map<String, dynamic> json) =>
      _$_$_AuthenticationEntityFromJson(json);

  @override
  @JsonKey(name: 'token')
  final String authenticationToken;
  @override
  @JsonKey(name: 'end_user_id')
  final int userId;
  @override
  @JsonKey(name: 'name')
  final String nickname;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthenticationEntity(authenticationToken: $authenticationToken, userId: $userId, nickname: $nickname)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthenticationEntity'))
      ..add(DiagnosticsProperty('authenticationToken', authenticationToken))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('nickname', nickname));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AuthenticationEntity &&
            (identical(other.authenticationToken, authenticationToken) ||
                const DeepCollectionEquality()
                    .equals(other.authenticationToken, authenticationToken)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality()
                    .equals(other.nickname, nickname)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(authenticationToken) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(nickname);

  @JsonKey(ignore: true)
  @override
  _$AuthenticationEntityCopyWith<_AuthenticationEntity> get copyWith =>
      __$AuthenticationEntityCopyWithImpl<_AuthenticationEntity>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_AuthenticationEntityToJson(this);
  }
}

abstract class _AuthenticationEntity implements AuthenticationEntity {
  const factory _AuthenticationEntity(
          {@JsonKey(name: 'token') required String authenticationToken,
          @JsonKey(name: 'end_user_id') required int userId,
          @JsonKey(name: 'name') required String nickname}) =
      _$_AuthenticationEntity;

  factory _AuthenticationEntity.fromJson(Map<String, dynamic> json) =
      _$_AuthenticationEntity.fromJson;

  @override
  @JsonKey(name: 'token')
  String get authenticationToken => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'end_user_id')
  int get userId => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'name')
  String get nickname => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AuthenticationEntityCopyWith<_AuthenticationEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
