// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'favorite_patient_card_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FavoritePatientCardEntity _$FavoritePatientCardEntityFromJson(
    Map<String, dynamic> json) {
  return _FavoritePatientCardEntity.fromJson(json);
}

/// @nodoc
class _$FavoritePatientCardEntityTearOff {
  const _$FavoritePatientCardEntityTearOff();

  _FavoritePatientCardEntity call(
      {@JsonKey(name: 'institution_id') required int institutionId,
      @JsonKey(name: 'end_user_id') required int userId,
      required String nickname,
      @JsonKey(name: 'local_id') String? localId,
      @JsonKey(name: 'reserve_at') String? reserveDate,
      @JsonKey(name: 'last_reception_at') String? lastReceptionDate,
      @JsonKey(name: 'is_patient') required bool isPatient}) {
    return _FavoritePatientCardEntity(
      institutionId: institutionId,
      userId: userId,
      nickname: nickname,
      localId: localId,
      reserveDate: reserveDate,
      lastReceptionDate: lastReceptionDate,
      isPatient: isPatient,
    );
  }

  FavoritePatientCardEntity fromJson(Map<String, Object> json) {
    return FavoritePatientCardEntity.fromJson(json);
  }
}

/// @nodoc
const $FavoritePatientCardEntity = _$FavoritePatientCardEntityTearOff();

/// @nodoc
mixin _$FavoritePatientCardEntity {
  @JsonKey(name: 'institution_id')
  int get institutionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_user_id')
  int get userId => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  @JsonKey(name: 'local_id')
  String? get localId => throw _privateConstructorUsedError;
  @JsonKey(name: 'reserve_at')
  String? get reserveDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_reception_at')
  String? get lastReceptionDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_patient')
  bool get isPatient => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FavoritePatientCardEntityCopyWith<FavoritePatientCardEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoritePatientCardEntityCopyWith<$Res> {
  factory $FavoritePatientCardEntityCopyWith(FavoritePatientCardEntity value,
          $Res Function(FavoritePatientCardEntity) then) =
      _$FavoritePatientCardEntityCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'institution_id') int institutionId,
      @JsonKey(name: 'end_user_id') int userId,
      String nickname,
      @JsonKey(name: 'local_id') String? localId,
      @JsonKey(name: 'reserve_at') String? reserveDate,
      @JsonKey(name: 'last_reception_at') String? lastReceptionDate,
      @JsonKey(name: 'is_patient') bool isPatient});
}

/// @nodoc
class _$FavoritePatientCardEntityCopyWithImpl<$Res>
    implements $FavoritePatientCardEntityCopyWith<$Res> {
  _$FavoritePatientCardEntityCopyWithImpl(this._value, this._then);

  final FavoritePatientCardEntity _value;
  // ignore: unused_field
  final $Res Function(FavoritePatientCardEntity) _then;

  @override
  $Res call({
    Object? institutionId = freezed,
    Object? userId = freezed,
    Object? nickname = freezed,
    Object? localId = freezed,
    Object? reserveDate = freezed,
    Object? lastReceptionDate = freezed,
    Object? isPatient = freezed,
  }) {
    return _then(_value.copyWith(
      institutionId: institutionId == freezed
          ? _value.institutionId
          : institutionId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: nickname == freezed
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      localId: localId == freezed
          ? _value.localId
          : localId // ignore: cast_nullable_to_non_nullable
              as String?,
      reserveDate: reserveDate == freezed
          ? _value.reserveDate
          : reserveDate // ignore: cast_nullable_to_non_nullable
              as String?,
      lastReceptionDate: lastReceptionDate == freezed
          ? _value.lastReceptionDate
          : lastReceptionDate // ignore: cast_nullable_to_non_nullable
              as String?,
      isPatient: isPatient == freezed
          ? _value.isPatient
          : isPatient // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$FavoritePatientCardEntityCopyWith<$Res>
    implements $FavoritePatientCardEntityCopyWith<$Res> {
  factory _$FavoritePatientCardEntityCopyWith(_FavoritePatientCardEntity value,
          $Res Function(_FavoritePatientCardEntity) then) =
      __$FavoritePatientCardEntityCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'institution_id') int institutionId,
      @JsonKey(name: 'end_user_id') int userId,
      String nickname,
      @JsonKey(name: 'local_id') String? localId,
      @JsonKey(name: 'reserve_at') String? reserveDate,
      @JsonKey(name: 'last_reception_at') String? lastReceptionDate,
      @JsonKey(name: 'is_patient') bool isPatient});
}

/// @nodoc
class __$FavoritePatientCardEntityCopyWithImpl<$Res>
    extends _$FavoritePatientCardEntityCopyWithImpl<$Res>
    implements _$FavoritePatientCardEntityCopyWith<$Res> {
  __$FavoritePatientCardEntityCopyWithImpl(_FavoritePatientCardEntity _value,
      $Res Function(_FavoritePatientCardEntity) _then)
      : super(_value, (v) => _then(v as _FavoritePatientCardEntity));

  @override
  _FavoritePatientCardEntity get _value =>
      super._value as _FavoritePatientCardEntity;

  @override
  $Res call({
    Object? institutionId = freezed,
    Object? userId = freezed,
    Object? nickname = freezed,
    Object? localId = freezed,
    Object? reserveDate = freezed,
    Object? lastReceptionDate = freezed,
    Object? isPatient = freezed,
  }) {
    return _then(_FavoritePatientCardEntity(
      institutionId: institutionId == freezed
          ? _value.institutionId
          : institutionId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: nickname == freezed
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      localId: localId == freezed
          ? _value.localId
          : localId // ignore: cast_nullable_to_non_nullable
              as String?,
      reserveDate: reserveDate == freezed
          ? _value.reserveDate
          : reserveDate // ignore: cast_nullable_to_non_nullable
              as String?,
      lastReceptionDate: lastReceptionDate == freezed
          ? _value.lastReceptionDate
          : lastReceptionDate // ignore: cast_nullable_to_non_nullable
              as String?,
      isPatient: isPatient == freezed
          ? _value.isPatient
          : isPatient // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FavoritePatientCardEntity
    with DiagnosticableTreeMixin
    implements _FavoritePatientCardEntity {
  const _$_FavoritePatientCardEntity(
      {@JsonKey(name: 'institution_id') required this.institutionId,
      @JsonKey(name: 'end_user_id') required this.userId,
      required this.nickname,
      @JsonKey(name: 'local_id') this.localId,
      @JsonKey(name: 'reserve_at') this.reserveDate,
      @JsonKey(name: 'last_reception_at') this.lastReceptionDate,
      @JsonKey(name: 'is_patient') required this.isPatient});

  factory _$_FavoritePatientCardEntity.fromJson(Map<String, dynamic> json) =>
      _$_$_FavoritePatientCardEntityFromJson(json);

  @override
  @JsonKey(name: 'institution_id')
  final int institutionId;
  @override
  @JsonKey(name: 'end_user_id')
  final int userId;
  @override
  final String nickname;
  @override
  @JsonKey(name: 'local_id')
  final String? localId;
  @override
  @JsonKey(name: 'reserve_at')
  final String? reserveDate;
  @override
  @JsonKey(name: 'last_reception_at')
  final String? lastReceptionDate;
  @override
  @JsonKey(name: 'is_patient')
  final bool isPatient;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FavoritePatientCardEntity(institutionId: $institutionId, userId: $userId, nickname: $nickname, localId: $localId, reserveDate: $reserveDate, lastReceptionDate: $lastReceptionDate, isPatient: $isPatient)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FavoritePatientCardEntity'))
      ..add(DiagnosticsProperty('institutionId', institutionId))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('nickname', nickname))
      ..add(DiagnosticsProperty('localId', localId))
      ..add(DiagnosticsProperty('reserveDate', reserveDate))
      ..add(DiagnosticsProperty('lastReceptionDate', lastReceptionDate))
      ..add(DiagnosticsProperty('isPatient', isPatient));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FavoritePatientCardEntity &&
            (identical(other.institutionId, institutionId) ||
                const DeepCollectionEquality()
                    .equals(other.institutionId, institutionId)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality()
                    .equals(other.nickname, nickname)) &&
            (identical(other.localId, localId) ||
                const DeepCollectionEquality()
                    .equals(other.localId, localId)) &&
            (identical(other.reserveDate, reserveDate) ||
                const DeepCollectionEquality()
                    .equals(other.reserveDate, reserveDate)) &&
            (identical(other.lastReceptionDate, lastReceptionDate) ||
                const DeepCollectionEquality()
                    .equals(other.lastReceptionDate, lastReceptionDate)) &&
            (identical(other.isPatient, isPatient) ||
                const DeepCollectionEquality()
                    .equals(other.isPatient, isPatient)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(institutionId) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(nickname) ^
      const DeepCollectionEquality().hash(localId) ^
      const DeepCollectionEquality().hash(reserveDate) ^
      const DeepCollectionEquality().hash(lastReceptionDate) ^
      const DeepCollectionEquality().hash(isPatient);

  @JsonKey(ignore: true)
  @override
  _$FavoritePatientCardEntityCopyWith<_FavoritePatientCardEntity>
      get copyWith =>
          __$FavoritePatientCardEntityCopyWithImpl<_FavoritePatientCardEntity>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_FavoritePatientCardEntityToJson(this);
  }
}

abstract class _FavoritePatientCardEntity implements FavoritePatientCardEntity {
  const factory _FavoritePatientCardEntity(
          {@JsonKey(name: 'institution_id') required int institutionId,
          @JsonKey(name: 'end_user_id') required int userId,
          required String nickname,
          @JsonKey(name: 'local_id') String? localId,
          @JsonKey(name: 'reserve_at') String? reserveDate,
          @JsonKey(name: 'last_reception_at') String? lastReceptionDate,
          @JsonKey(name: 'is_patient') required bool isPatient}) =
      _$_FavoritePatientCardEntity;

  factory _FavoritePatientCardEntity.fromJson(Map<String, dynamic> json) =
      _$_FavoritePatientCardEntity.fromJson;

  @override
  @JsonKey(name: 'institution_id')
  int get institutionId => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'end_user_id')
  int get userId => throw _privateConstructorUsedError;
  @override
  String get nickname => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'local_id')
  String? get localId => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'reserve_at')
  String? get reserveDate => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'last_reception_at')
  String? get lastReceptionDate => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'is_patient')
  bool get isPatient => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FavoritePatientCardEntityCopyWith<_FavoritePatientCardEntity>
      get copyWith => throw _privateConstructorUsedError;
}
