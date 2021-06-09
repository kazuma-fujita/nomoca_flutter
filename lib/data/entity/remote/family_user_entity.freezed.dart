// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'family_user_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FamilyUserEntity _$FamilyUserEntityFromJson(Map<String, dynamic> json) {
  return _FamilyUserEntity.fromJson(json);
}

/// @nodoc
class _$FamilyUserEntityTearOff {
  const _$FamilyUserEntityTearOff();

  _FamilyUserEntity call(
      {required int id, @JsonKey(name: 'name') required String nickname}) {
    return _FamilyUserEntity(
      id: id,
      nickname: nickname,
    );
  }

  FamilyUserEntity fromJson(Map<String, Object> json) {
    return FamilyUserEntity.fromJson(json);
  }
}

/// @nodoc
const $FamilyUserEntity = _$FamilyUserEntityTearOff();

/// @nodoc
mixin _$FamilyUserEntity {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get nickname => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FamilyUserEntityCopyWith<FamilyUserEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FamilyUserEntityCopyWith<$Res> {
  factory $FamilyUserEntityCopyWith(
          FamilyUserEntity value, $Res Function(FamilyUserEntity) then) =
      _$FamilyUserEntityCopyWithImpl<$Res>;
  $Res call({int id, @JsonKey(name: 'name') String nickname});
}

/// @nodoc
class _$FamilyUserEntityCopyWithImpl<$Res>
    implements $FamilyUserEntityCopyWith<$Res> {
  _$FamilyUserEntityCopyWithImpl(this._value, this._then);

  final FamilyUserEntity _value;
  // ignore: unused_field
  final $Res Function(FamilyUserEntity) _then;

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
abstract class _$FamilyUserEntityCopyWith<$Res>
    implements $FamilyUserEntityCopyWith<$Res> {
  factory _$FamilyUserEntityCopyWith(
          _FamilyUserEntity value, $Res Function(_FamilyUserEntity) then) =
      __$FamilyUserEntityCopyWithImpl<$Res>;
  @override
  $Res call({int id, @JsonKey(name: 'name') String nickname});
}

/// @nodoc
class __$FamilyUserEntityCopyWithImpl<$Res>
    extends _$FamilyUserEntityCopyWithImpl<$Res>
    implements _$FamilyUserEntityCopyWith<$Res> {
  __$FamilyUserEntityCopyWithImpl(
      _FamilyUserEntity _value, $Res Function(_FamilyUserEntity) _then)
      : super(_value, (v) => _then(v as _FamilyUserEntity));

  @override
  _FamilyUserEntity get _value => super._value as _FamilyUserEntity;

  @override
  $Res call({
    Object? id = freezed,
    Object? nickname = freezed,
  }) {
    return _then(_FamilyUserEntity(
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
class _$_FamilyUserEntity
    with DiagnosticableTreeMixin
    implements _FamilyUserEntity {
  const _$_FamilyUserEntity(
      {required this.id, @JsonKey(name: 'name') required this.nickname});

  factory _$_FamilyUserEntity.fromJson(Map<String, dynamic> json) =>
      _$_$_FamilyUserEntityFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'name')
  final String nickname;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FamilyUserEntity(id: $id, nickname: $nickname)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FamilyUserEntity'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('nickname', nickname));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FamilyUserEntity &&
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
  _$FamilyUserEntityCopyWith<_FamilyUserEntity> get copyWith =>
      __$FamilyUserEntityCopyWithImpl<_FamilyUserEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_FamilyUserEntityToJson(this);
  }
}

abstract class _FamilyUserEntity implements FamilyUserEntity {
  const factory _FamilyUserEntity(
      {required int id,
      @JsonKey(name: 'name') required String nickname}) = _$_FamilyUserEntity;

  factory _FamilyUserEntity.fromJson(Map<String, dynamic> json) =
      _$_FamilyUserEntity.fromJson;

  @override
  int get id => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'name')
  String get nickname => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FamilyUserEntityCopyWith<_FamilyUserEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
