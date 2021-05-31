// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'patient_card_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PatientCardEntity _$PatientCardEntityFromJson(Map<String, dynamic> json) {
  return _PatientCardEntity.fromJson(json);
}

/// @nodoc
class _$PatientCardEntityTearOff {
  const _$PatientCardEntityTearOff();

  _PatientCardEntity call(
      {@JsonKey(name: 'name') required String nickname,
      @JsonKey(name: 'qr_code_image') required String qrCodeImageUrl}) {
    return _PatientCardEntity(
      nickname: nickname,
      qrCodeImageUrl: qrCodeImageUrl,
    );
  }

  PatientCardEntity fromJson(Map<String, Object> json) {
    return PatientCardEntity.fromJson(json);
  }
}

/// @nodoc
const $PatientCardEntity = _$PatientCardEntityTearOff();

/// @nodoc
mixin _$PatientCardEntity {
  @JsonKey(name: 'name')
  String get nickname => throw _privateConstructorUsedError;
  @JsonKey(name: 'qr_code_image')
  String get qrCodeImageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PatientCardEntityCopyWith<PatientCardEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatientCardEntityCopyWith<$Res> {
  factory $PatientCardEntityCopyWith(
          PatientCardEntity value, $Res Function(PatientCardEntity) then) =
      _$PatientCardEntityCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'name') String nickname,
      @JsonKey(name: 'qr_code_image') String qrCodeImageUrl});
}

/// @nodoc
class _$PatientCardEntityCopyWithImpl<$Res>
    implements $PatientCardEntityCopyWith<$Res> {
  _$PatientCardEntityCopyWithImpl(this._value, this._then);

  final PatientCardEntity _value;
  // ignore: unused_field
  final $Res Function(PatientCardEntity) _then;

  @override
  $Res call({
    Object? nickname = freezed,
    Object? qrCodeImageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      nickname: nickname == freezed
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      qrCodeImageUrl: qrCodeImageUrl == freezed
          ? _value.qrCodeImageUrl
          : qrCodeImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$PatientCardEntityCopyWith<$Res>
    implements $PatientCardEntityCopyWith<$Res> {
  factory _$PatientCardEntityCopyWith(
          _PatientCardEntity value, $Res Function(_PatientCardEntity) then) =
      __$PatientCardEntityCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'name') String nickname,
      @JsonKey(name: 'qr_code_image') String qrCodeImageUrl});
}

/// @nodoc
class __$PatientCardEntityCopyWithImpl<$Res>
    extends _$PatientCardEntityCopyWithImpl<$Res>
    implements _$PatientCardEntityCopyWith<$Res> {
  __$PatientCardEntityCopyWithImpl(
      _PatientCardEntity _value, $Res Function(_PatientCardEntity) _then)
      : super(_value, (v) => _then(v as _PatientCardEntity));

  @override
  _PatientCardEntity get _value => super._value as _PatientCardEntity;

  @override
  $Res call({
    Object? nickname = freezed,
    Object? qrCodeImageUrl = freezed,
  }) {
    return _then(_PatientCardEntity(
      nickname: nickname == freezed
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      qrCodeImageUrl: qrCodeImageUrl == freezed
          ? _value.qrCodeImageUrl
          : qrCodeImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PatientCardEntity
    with DiagnosticableTreeMixin
    implements _PatientCardEntity {
  const _$_PatientCardEntity(
      {@JsonKey(name: 'name') required this.nickname,
      @JsonKey(name: 'qr_code_image') required this.qrCodeImageUrl});

  factory _$_PatientCardEntity.fromJson(Map<String, dynamic> json) =>
      _$_$_PatientCardEntityFromJson(json);

  @override
  @JsonKey(name: 'name')
  final String nickname;
  @override
  @JsonKey(name: 'qr_code_image')
  final String qrCodeImageUrl;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PatientCardEntity(nickname: $nickname, qrCodeImageUrl: $qrCodeImageUrl)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PatientCardEntity'))
      ..add(DiagnosticsProperty('nickname', nickname))
      ..add(DiagnosticsProperty('qrCodeImageUrl', qrCodeImageUrl));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PatientCardEntity &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality()
                    .equals(other.nickname, nickname)) &&
            (identical(other.qrCodeImageUrl, qrCodeImageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.qrCodeImageUrl, qrCodeImageUrl)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(nickname) ^
      const DeepCollectionEquality().hash(qrCodeImageUrl);

  @JsonKey(ignore: true)
  @override
  _$PatientCardEntityCopyWith<_PatientCardEntity> get copyWith =>
      __$PatientCardEntityCopyWithImpl<_PatientCardEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_PatientCardEntityToJson(this);
  }
}

abstract class _PatientCardEntity implements PatientCardEntity {
  const factory _PatientCardEntity(
          {@JsonKey(name: 'name') required String nickname,
          @JsonKey(name: 'qr_code_image') required String qrCodeImageUrl}) =
      _$_PatientCardEntity;

  factory _PatientCardEntity.fromJson(Map<String, dynamic> json) =
      _$_PatientCardEntity.fromJson;

  @override
  @JsonKey(name: 'name')
  String get nickname => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'qr_code_image')
  String get qrCodeImageUrl => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PatientCardEntityCopyWith<_PatientCardEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
