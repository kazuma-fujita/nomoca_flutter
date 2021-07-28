// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'preview_cards_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PreviewCardsEntity _$PreviewCardsEntityFromJson(Map<String, dynamic> json) {
  return _PreviewCardsEntity.fromJson(json);
}

/// @nodoc
class _$PreviewCardsEntityTearOff {
  const _$PreviewCardsEntityTearOff();

  _PreviewCardsEntity call(
      {@JsonKey(name: 'id')
          required int sourceUserId,
      @JsonKey(name: 'patients')
          required List<PreviewCardPatientEntity> patients}) {
    return _PreviewCardsEntity(
      sourceUserId: sourceUserId,
      patients: patients,
    );
  }

  PreviewCardsEntity fromJson(Map<String, Object> json) {
    return PreviewCardsEntity.fromJson(json);
  }
}

/// @nodoc
const $PreviewCardsEntity = _$PreviewCardsEntityTearOff();

/// @nodoc
mixin _$PreviewCardsEntity {
  @JsonKey(name: 'id')
  int get sourceUserId => throw _privateConstructorUsedError;
  @JsonKey(name: 'patients')
  List<PreviewCardPatientEntity> get patients =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PreviewCardsEntityCopyWith<PreviewCardsEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreviewCardsEntityCopyWith<$Res> {
  factory $PreviewCardsEntityCopyWith(
          PreviewCardsEntity value, $Res Function(PreviewCardsEntity) then) =
      _$PreviewCardsEntityCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'id') int sourceUserId,
      @JsonKey(name: 'patients') List<PreviewCardPatientEntity> patients});
}

/// @nodoc
class _$PreviewCardsEntityCopyWithImpl<$Res>
    implements $PreviewCardsEntityCopyWith<$Res> {
  _$PreviewCardsEntityCopyWithImpl(this._value, this._then);

  final PreviewCardsEntity _value;
  // ignore: unused_field
  final $Res Function(PreviewCardsEntity) _then;

  @override
  $Res call({
    Object? sourceUserId = freezed,
    Object? patients = freezed,
  }) {
    return _then(_value.copyWith(
      sourceUserId: sourceUserId == freezed
          ? _value.sourceUserId
          : sourceUserId // ignore: cast_nullable_to_non_nullable
              as int,
      patients: patients == freezed
          ? _value.patients
          : patients // ignore: cast_nullable_to_non_nullable
              as List<PreviewCardPatientEntity>,
    ));
  }
}

/// @nodoc
abstract class _$PreviewCardsEntityCopyWith<$Res>
    implements $PreviewCardsEntityCopyWith<$Res> {
  factory _$PreviewCardsEntityCopyWith(
          _PreviewCardsEntity value, $Res Function(_PreviewCardsEntity) then) =
      __$PreviewCardsEntityCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'id') int sourceUserId,
      @JsonKey(name: 'patients') List<PreviewCardPatientEntity> patients});
}

/// @nodoc
class __$PreviewCardsEntityCopyWithImpl<$Res>
    extends _$PreviewCardsEntityCopyWithImpl<$Res>
    implements _$PreviewCardsEntityCopyWith<$Res> {
  __$PreviewCardsEntityCopyWithImpl(
      _PreviewCardsEntity _value, $Res Function(_PreviewCardsEntity) _then)
      : super(_value, (v) => _then(v as _PreviewCardsEntity));

  @override
  _PreviewCardsEntity get _value => super._value as _PreviewCardsEntity;

  @override
  $Res call({
    Object? sourceUserId = freezed,
    Object? patients = freezed,
  }) {
    return _then(_PreviewCardsEntity(
      sourceUserId: sourceUserId == freezed
          ? _value.sourceUserId
          : sourceUserId // ignore: cast_nullable_to_non_nullable
              as int,
      patients: patients == freezed
          ? _value.patients
          : patients // ignore: cast_nullable_to_non_nullable
              as List<PreviewCardPatientEntity>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PreviewCardsEntity
    with DiagnosticableTreeMixin
    implements _PreviewCardsEntity {
  const _$_PreviewCardsEntity(
      {@JsonKey(name: 'id') required this.sourceUserId,
      @JsonKey(name: 'patients') required this.patients});

  factory _$_PreviewCardsEntity.fromJson(Map<String, dynamic> json) =>
      _$_$_PreviewCardsEntityFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int sourceUserId;
  @override
  @JsonKey(name: 'patients')
  final List<PreviewCardPatientEntity> patients;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PreviewCardsEntity(sourceUserId: $sourceUserId, patients: $patients)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PreviewCardsEntity'))
      ..add(DiagnosticsProperty('sourceUserId', sourceUserId))
      ..add(DiagnosticsProperty('patients', patients));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PreviewCardsEntity &&
            (identical(other.sourceUserId, sourceUserId) ||
                const DeepCollectionEquality()
                    .equals(other.sourceUserId, sourceUserId)) &&
            (identical(other.patients, patients) ||
                const DeepCollectionEquality()
                    .equals(other.patients, patients)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(sourceUserId) ^
      const DeepCollectionEquality().hash(patients);

  @JsonKey(ignore: true)
  @override
  _$PreviewCardsEntityCopyWith<_PreviewCardsEntity> get copyWith =>
      __$PreviewCardsEntityCopyWithImpl<_PreviewCardsEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_PreviewCardsEntityToJson(this);
  }
}

abstract class _PreviewCardsEntity implements PreviewCardsEntity {
  const factory _PreviewCardsEntity(
          {@JsonKey(name: 'id')
              required int sourceUserId,
          @JsonKey(name: 'patients')
              required List<PreviewCardPatientEntity> patients}) =
      _$_PreviewCardsEntity;

  factory _PreviewCardsEntity.fromJson(Map<String, dynamic> json) =
      _$_PreviewCardsEntity.fromJson;

  @override
  @JsonKey(name: 'id')
  int get sourceUserId => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'patients')
  List<PreviewCardPatientEntity> get patients =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PreviewCardsEntityCopyWith<_PreviewCardsEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

PreviewCardPatientEntity _$PreviewCardPatientEntityFromJson(
    Map<String, dynamic> json) {
  return _PreviewCardPatientEntity.fromJson(json);
}

/// @nodoc
class _$PreviewCardPatientEntityTearOff {
  const _$PreviewCardPatientEntityTearOff();

  _PreviewCardPatientEntity call(
      {@JsonKey(name: 'name_kana')
          required String nameKana,
      @JsonKey(name: 'local_id')
          required String localId,
      @JsonKey(name: 'institution')
          required PreviewCardInstitutionEntity institution}) {
    return _PreviewCardPatientEntity(
      nameKana: nameKana,
      localId: localId,
      institution: institution,
    );
  }

  PreviewCardPatientEntity fromJson(Map<String, Object> json) {
    return PreviewCardPatientEntity.fromJson(json);
  }
}

/// @nodoc
const $PreviewCardPatientEntity = _$PreviewCardPatientEntityTearOff();

/// @nodoc
mixin _$PreviewCardPatientEntity {
  @JsonKey(name: 'name_kana')
  String get nameKana => throw _privateConstructorUsedError;
  @JsonKey(name: 'local_id')
  String get localId => throw _privateConstructorUsedError;
  @JsonKey(name: 'institution')
  PreviewCardInstitutionEntity get institution =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PreviewCardPatientEntityCopyWith<PreviewCardPatientEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreviewCardPatientEntityCopyWith<$Res> {
  factory $PreviewCardPatientEntityCopyWith(PreviewCardPatientEntity value,
          $Res Function(PreviewCardPatientEntity) then) =
      _$PreviewCardPatientEntityCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'name_kana') String nameKana,
      @JsonKey(name: 'local_id') String localId,
      @JsonKey(name: 'institution') PreviewCardInstitutionEntity institution});

  $PreviewCardInstitutionEntityCopyWith<$Res> get institution;
}

/// @nodoc
class _$PreviewCardPatientEntityCopyWithImpl<$Res>
    implements $PreviewCardPatientEntityCopyWith<$Res> {
  _$PreviewCardPatientEntityCopyWithImpl(this._value, this._then);

  final PreviewCardPatientEntity _value;
  // ignore: unused_field
  final $Res Function(PreviewCardPatientEntity) _then;

  @override
  $Res call({
    Object? nameKana = freezed,
    Object? localId = freezed,
    Object? institution = freezed,
  }) {
    return _then(_value.copyWith(
      nameKana: nameKana == freezed
          ? _value.nameKana
          : nameKana // ignore: cast_nullable_to_non_nullable
              as String,
      localId: localId == freezed
          ? _value.localId
          : localId // ignore: cast_nullable_to_non_nullable
              as String,
      institution: institution == freezed
          ? _value.institution
          : institution // ignore: cast_nullable_to_non_nullable
              as PreviewCardInstitutionEntity,
    ));
  }

  @override
  $PreviewCardInstitutionEntityCopyWith<$Res> get institution {
    return $PreviewCardInstitutionEntityCopyWith<$Res>(_value.institution,
        (value) {
      return _then(_value.copyWith(institution: value));
    });
  }
}

/// @nodoc
abstract class _$PreviewCardPatientEntityCopyWith<$Res>
    implements $PreviewCardPatientEntityCopyWith<$Res> {
  factory _$PreviewCardPatientEntityCopyWith(_PreviewCardPatientEntity value,
          $Res Function(_PreviewCardPatientEntity) then) =
      __$PreviewCardPatientEntityCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'name_kana') String nameKana,
      @JsonKey(name: 'local_id') String localId,
      @JsonKey(name: 'institution') PreviewCardInstitutionEntity institution});

  @override
  $PreviewCardInstitutionEntityCopyWith<$Res> get institution;
}

/// @nodoc
class __$PreviewCardPatientEntityCopyWithImpl<$Res>
    extends _$PreviewCardPatientEntityCopyWithImpl<$Res>
    implements _$PreviewCardPatientEntityCopyWith<$Res> {
  __$PreviewCardPatientEntityCopyWithImpl(_PreviewCardPatientEntity _value,
      $Res Function(_PreviewCardPatientEntity) _then)
      : super(_value, (v) => _then(v as _PreviewCardPatientEntity));

  @override
  _PreviewCardPatientEntity get _value =>
      super._value as _PreviewCardPatientEntity;

  @override
  $Res call({
    Object? nameKana = freezed,
    Object? localId = freezed,
    Object? institution = freezed,
  }) {
    return _then(_PreviewCardPatientEntity(
      nameKana: nameKana == freezed
          ? _value.nameKana
          : nameKana // ignore: cast_nullable_to_non_nullable
              as String,
      localId: localId == freezed
          ? _value.localId
          : localId // ignore: cast_nullable_to_non_nullable
              as String,
      institution: institution == freezed
          ? _value.institution
          : institution // ignore: cast_nullable_to_non_nullable
              as PreviewCardInstitutionEntity,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PreviewCardPatientEntity
    with DiagnosticableTreeMixin
    implements _PreviewCardPatientEntity {
  const _$_PreviewCardPatientEntity(
      {@JsonKey(name: 'name_kana') required this.nameKana,
      @JsonKey(name: 'local_id') required this.localId,
      @JsonKey(name: 'institution') required this.institution});

  factory _$_PreviewCardPatientEntity.fromJson(Map<String, dynamic> json) =>
      _$_$_PreviewCardPatientEntityFromJson(json);

  @override
  @JsonKey(name: 'name_kana')
  final String nameKana;
  @override
  @JsonKey(name: 'local_id')
  final String localId;
  @override
  @JsonKey(name: 'institution')
  final PreviewCardInstitutionEntity institution;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PreviewCardPatientEntity(nameKana: $nameKana, localId: $localId, institution: $institution)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PreviewCardPatientEntity'))
      ..add(DiagnosticsProperty('nameKana', nameKana))
      ..add(DiagnosticsProperty('localId', localId))
      ..add(DiagnosticsProperty('institution', institution));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PreviewCardPatientEntity &&
            (identical(other.nameKana, nameKana) ||
                const DeepCollectionEquality()
                    .equals(other.nameKana, nameKana)) &&
            (identical(other.localId, localId) ||
                const DeepCollectionEquality()
                    .equals(other.localId, localId)) &&
            (identical(other.institution, institution) ||
                const DeepCollectionEquality()
                    .equals(other.institution, institution)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(nameKana) ^
      const DeepCollectionEquality().hash(localId) ^
      const DeepCollectionEquality().hash(institution);

  @JsonKey(ignore: true)
  @override
  _$PreviewCardPatientEntityCopyWith<_PreviewCardPatientEntity> get copyWith =>
      __$PreviewCardPatientEntityCopyWithImpl<_PreviewCardPatientEntity>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_PreviewCardPatientEntityToJson(this);
  }
}

abstract class _PreviewCardPatientEntity implements PreviewCardPatientEntity {
  const factory _PreviewCardPatientEntity(
          {@JsonKey(name: 'name_kana')
              required String nameKana,
          @JsonKey(name: 'local_id')
              required String localId,
          @JsonKey(name: 'institution')
              required PreviewCardInstitutionEntity institution}) =
      _$_PreviewCardPatientEntity;

  factory _PreviewCardPatientEntity.fromJson(Map<String, dynamic> json) =
      _$_PreviewCardPatientEntity.fromJson;

  @override
  @JsonKey(name: 'name_kana')
  String get nameKana => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'local_id')
  String get localId => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'institution')
  PreviewCardInstitutionEntity get institution =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PreviewCardPatientEntityCopyWith<_PreviewCardPatientEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

PreviewCardInstitutionEntity _$PreviewCardInstitutionEntityFromJson(
    Map<String, dynamic> json) {
  return _PreviewCardInstitutionEntity.fromJson(json);
}

/// @nodoc
class _$PreviewCardInstitutionEntityTearOff {
  const _$PreviewCardInstitutionEntityTearOff();

  _PreviewCardInstitutionEntity call(
      {@JsonKey(name: 'id') required int institutionId,
      @JsonKey(name: 'name') required String institutionName}) {
    return _PreviewCardInstitutionEntity(
      institutionId: institutionId,
      institutionName: institutionName,
    );
  }

  PreviewCardInstitutionEntity fromJson(Map<String, Object> json) {
    return PreviewCardInstitutionEntity.fromJson(json);
  }
}

/// @nodoc
const $PreviewCardInstitutionEntity = _$PreviewCardInstitutionEntityTearOff();

/// @nodoc
mixin _$PreviewCardInstitutionEntity {
  @JsonKey(name: 'id')
  int get institutionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get institutionName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PreviewCardInstitutionEntityCopyWith<PreviewCardInstitutionEntity>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreviewCardInstitutionEntityCopyWith<$Res> {
  factory $PreviewCardInstitutionEntityCopyWith(
          PreviewCardInstitutionEntity value,
          $Res Function(PreviewCardInstitutionEntity) then) =
      _$PreviewCardInstitutionEntityCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'id') int institutionId,
      @JsonKey(name: 'name') String institutionName});
}

/// @nodoc
class _$PreviewCardInstitutionEntityCopyWithImpl<$Res>
    implements $PreviewCardInstitutionEntityCopyWith<$Res> {
  _$PreviewCardInstitutionEntityCopyWithImpl(this._value, this._then);

  final PreviewCardInstitutionEntity _value;
  // ignore: unused_field
  final $Res Function(PreviewCardInstitutionEntity) _then;

  @override
  $Res call({
    Object? institutionId = freezed,
    Object? institutionName = freezed,
  }) {
    return _then(_value.copyWith(
      institutionId: institutionId == freezed
          ? _value.institutionId
          : institutionId // ignore: cast_nullable_to_non_nullable
              as int,
      institutionName: institutionName == freezed
          ? _value.institutionName
          : institutionName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$PreviewCardInstitutionEntityCopyWith<$Res>
    implements $PreviewCardInstitutionEntityCopyWith<$Res> {
  factory _$PreviewCardInstitutionEntityCopyWith(
          _PreviewCardInstitutionEntity value,
          $Res Function(_PreviewCardInstitutionEntity) then) =
      __$PreviewCardInstitutionEntityCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'id') int institutionId,
      @JsonKey(name: 'name') String institutionName});
}

/// @nodoc
class __$PreviewCardInstitutionEntityCopyWithImpl<$Res>
    extends _$PreviewCardInstitutionEntityCopyWithImpl<$Res>
    implements _$PreviewCardInstitutionEntityCopyWith<$Res> {
  __$PreviewCardInstitutionEntityCopyWithImpl(
      _PreviewCardInstitutionEntity _value,
      $Res Function(_PreviewCardInstitutionEntity) _then)
      : super(_value, (v) => _then(v as _PreviewCardInstitutionEntity));

  @override
  _PreviewCardInstitutionEntity get _value =>
      super._value as _PreviewCardInstitutionEntity;

  @override
  $Res call({
    Object? institutionId = freezed,
    Object? institutionName = freezed,
  }) {
    return _then(_PreviewCardInstitutionEntity(
      institutionId: institutionId == freezed
          ? _value.institutionId
          : institutionId // ignore: cast_nullable_to_non_nullable
              as int,
      institutionName: institutionName == freezed
          ? _value.institutionName
          : institutionName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PreviewCardInstitutionEntity
    with DiagnosticableTreeMixin
    implements _PreviewCardInstitutionEntity {
  const _$_PreviewCardInstitutionEntity(
      {@JsonKey(name: 'id') required this.institutionId,
      @JsonKey(name: 'name') required this.institutionName});

  factory _$_PreviewCardInstitutionEntity.fromJson(Map<String, dynamic> json) =>
      _$_$_PreviewCardInstitutionEntityFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int institutionId;
  @override
  @JsonKey(name: 'name')
  final String institutionName;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PreviewCardInstitutionEntity(institutionId: $institutionId, institutionName: $institutionName)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PreviewCardInstitutionEntity'))
      ..add(DiagnosticsProperty('institutionId', institutionId))
      ..add(DiagnosticsProperty('institutionName', institutionName));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PreviewCardInstitutionEntity &&
            (identical(other.institutionId, institutionId) ||
                const DeepCollectionEquality()
                    .equals(other.institutionId, institutionId)) &&
            (identical(other.institutionName, institutionName) ||
                const DeepCollectionEquality()
                    .equals(other.institutionName, institutionName)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(institutionId) ^
      const DeepCollectionEquality().hash(institutionName);

  @JsonKey(ignore: true)
  @override
  _$PreviewCardInstitutionEntityCopyWith<_PreviewCardInstitutionEntity>
      get copyWith => __$PreviewCardInstitutionEntityCopyWithImpl<
          _PreviewCardInstitutionEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_PreviewCardInstitutionEntityToJson(this);
  }
}

abstract class _PreviewCardInstitutionEntity
    implements PreviewCardInstitutionEntity {
  const factory _PreviewCardInstitutionEntity(
          {@JsonKey(name: 'id') required int institutionId,
          @JsonKey(name: 'name') required String institutionName}) =
      _$_PreviewCardInstitutionEntity;

  factory _PreviewCardInstitutionEntity.fromJson(Map<String, dynamic> json) =
      _$_PreviewCardInstitutionEntity.fromJson;

  @override
  @JsonKey(name: 'id')
  int get institutionId => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'name')
  String get institutionName => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PreviewCardInstitutionEntityCopyWith<_PreviewCardInstitutionEntity>
      get copyWith => throw _privateConstructorUsedError;
}
