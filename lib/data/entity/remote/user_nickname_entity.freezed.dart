// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'user_nickname_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserNicknameEntity _$UserNicknameEntityFromJson(Map<String, dynamic> json) {
  return _UserNicknameEntity.fromJson(json);
}

/// @nodoc
class _$UserNicknameEntityTearOff {
  const _$UserNicknameEntityTearOff();

  _UserNicknameEntity call(
      {required int id, @JsonKey(name: 'name') required String nickname}) {
    return _UserNicknameEntity(
      id: id,
      nickname: nickname,
    );
  }

  UserNicknameEntity fromJson(Map<String, Object> json) {
    return UserNicknameEntity.fromJson(json);
  }
}

/// @nodoc
const $UserNicknameEntity = _$UserNicknameEntityTearOff();

/// @nodoc
mixin _$UserNicknameEntity {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get nickname => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserNicknameEntityCopyWith<UserNicknameEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserNicknameEntityCopyWith<$Res> {
  factory $UserNicknameEntityCopyWith(
          UserNicknameEntity value, $Res Function(UserNicknameEntity) then) =
      _$UserNicknameEntityCopyWithImpl<$Res>;
  $Res call({int id, @JsonKey(name: 'name') String nickname});
}

/// @nodoc
class _$UserNicknameEntityCopyWithImpl<$Res>
    implements $UserNicknameEntityCopyWith<$Res> {
  _$UserNicknameEntityCopyWithImpl(this._value, this._then);

  final UserNicknameEntity _value;
  // ignore: unused_field
  final $Res Function(UserNicknameEntity) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? nickname = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: nickname == freezed
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$UserNicknameEntityCopyWith<$Res>
    implements $UserNicknameEntityCopyWith<$Res> {
  factory _$UserNicknameEntityCopyWith(
          _UserNicknameEntity value, $Res Function(_UserNicknameEntity) then) =
      __$UserNicknameEntityCopyWithImpl<$Res>;
  @override
  $Res call({int id, @JsonKey(name: 'name') String nickname});
}

/// @nodoc
class __$UserNicknameEntityCopyWithImpl<$Res>
    extends _$UserNicknameEntityCopyWithImpl<$Res>
    implements _$UserNicknameEntityCopyWith<$Res> {
  __$UserNicknameEntityCopyWithImpl(
      _UserNicknameEntity _value, $Res Function(_UserNicknameEntity) _then)
      : super(_value, (v) => _then(v as _UserNicknameEntity));

  @override
  _UserNicknameEntity get _value => super._value as _UserNicknameEntity;

  @override
  $Res call({
    Object? id = freezed,
    Object? nickname = freezed,
  }) {
    return _then(_UserNicknameEntity(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
class _$_UserNicknameEntity
    with DiagnosticableTreeMixin
    implements _UserNicknameEntity {
  const _$_UserNicknameEntity(
      {required this.id, @JsonKey(name: 'name') required this.nickname});

  factory _$_UserNicknameEntity.fromJson(Map<String, dynamic> json) =>
      _$_$_UserNicknameEntityFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'name')
  final String nickname;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserNicknameEntity(id: $id, nickname: $nickname)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserNicknameEntity'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('nickname', nickname));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UserNicknameEntity &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality()
                    .equals(other.nickname, nickname)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(nickname);

  @JsonKey(ignore: true)
  @override
  _$UserNicknameEntityCopyWith<_UserNicknameEntity> get copyWith =>
      __$UserNicknameEntityCopyWithImpl<_UserNicknameEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_UserNicknameEntityToJson(this);
  }
}

abstract class _UserNicknameEntity implements UserNicknameEntity {
  const factory _UserNicknameEntity(
      {required int id,
      @JsonKey(name: 'name') required String nickname}) = _$_UserNicknameEntity;

  factory _UserNicknameEntity.fromJson(Map<String, dynamic> json) =
      _$_UserNicknameEntity.fromJson;

  @override
  int get id => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'name')
  String get nickname => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$UserNicknameEntityCopyWith<_UserNicknameEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
