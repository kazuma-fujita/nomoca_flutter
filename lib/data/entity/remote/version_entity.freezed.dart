// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'version_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VersionEntity _$VersionEntityFromJson(Map<String, dynamic> json) {
  return _VersionEntity.fromJson(json);
}

/// @nodoc
class _$VersionEntityTearOff {
  const _$VersionEntityTearOff();

  _VersionEntity call({required String version}) {
    return _VersionEntity(
      version: version,
    );
  }

  VersionEntity fromJson(Map<String, Object> json) {
    return VersionEntity.fromJson(json);
  }
}

/// @nodoc
const $VersionEntity = _$VersionEntityTearOff();

/// @nodoc
mixin _$VersionEntity {
  String get version => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VersionEntityCopyWith<VersionEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VersionEntityCopyWith<$Res> {
  factory $VersionEntityCopyWith(
          VersionEntity value, $Res Function(VersionEntity) then) =
      _$VersionEntityCopyWithImpl<$Res>;
  $Res call({String version});
}

/// @nodoc
class _$VersionEntityCopyWithImpl<$Res>
    implements $VersionEntityCopyWith<$Res> {
  _$VersionEntityCopyWithImpl(this._value, this._then);

  final VersionEntity _value;
  // ignore: unused_field
  final $Res Function(VersionEntity) _then;

  @override
  $Res call({
    Object? version = freezed,
  }) {
    return _then(_value.copyWith(
      version: version == freezed
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$VersionEntityCopyWith<$Res>
    implements $VersionEntityCopyWith<$Res> {
  factory _$VersionEntityCopyWith(
          _VersionEntity value, $Res Function(_VersionEntity) then) =
      __$VersionEntityCopyWithImpl<$Res>;
  @override
  $Res call({String version});
}

/// @nodoc
class __$VersionEntityCopyWithImpl<$Res>
    extends _$VersionEntityCopyWithImpl<$Res>
    implements _$VersionEntityCopyWith<$Res> {
  __$VersionEntityCopyWithImpl(
      _VersionEntity _value, $Res Function(_VersionEntity) _then)
      : super(_value, (v) => _then(v as _VersionEntity));

  @override
  _VersionEntity get _value => super._value as _VersionEntity;

  @override
  $Res call({
    Object? version = freezed,
  }) {
    return _then(_VersionEntity(
      version: version == freezed
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_VersionEntity with DiagnosticableTreeMixin implements _VersionEntity {
  const _$_VersionEntity({required this.version});

  factory _$_VersionEntity.fromJson(Map<String, dynamic> json) =>
      _$_$_VersionEntityFromJson(json);

  @override
  final String version;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'VersionEntity(version: $version)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'VersionEntity'))
      ..add(DiagnosticsProperty('version', version));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _VersionEntity &&
            (identical(other.version, version) ||
                const DeepCollectionEquality().equals(other.version, version)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(version);

  @JsonKey(ignore: true)
  @override
  _$VersionEntityCopyWith<_VersionEntity> get copyWith =>
      __$VersionEntityCopyWithImpl<_VersionEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_VersionEntityToJson(this);
  }
}

abstract class _VersionEntity implements VersionEntity {
  const factory _VersionEntity({required String version}) = _$_VersionEntity;

  factory _VersionEntity.fromJson(Map<String, dynamic> json) =
      _$_VersionEntity.fromJson;

  @override
  String get version => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$VersionEntityCopyWith<_VersionEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
