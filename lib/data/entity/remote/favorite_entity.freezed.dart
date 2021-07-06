// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'favorite_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FavoriteEntity _$FavoriteEntityFromJson(Map<String, dynamic> json) {
  return _FavoriteEntity.fromJson(json);
}

/// @nodoc
class _$FavoriteEntityTearOff {
  const _$FavoriteEntityTearOff();

  _FavoriteEntity call(
      {@JsonKey(name: 'institution_id') required int institutionId,
      required String type,
      required String name,
      String? image1,
      String? image2,
      String? image3,
      String? image4,
      String? image5,
      @JsonKey(name: 'end_user_ids') required List<int> userIds,
      List<String>? images}) {
    return _FavoriteEntity(
      institutionId: institutionId,
      type: type,
      name: name,
      image1: image1,
      image2: image2,
      image3: image3,
      image4: image4,
      image5: image5,
      userIds: userIds,
      images: images,
    );
  }

  FavoriteEntity fromJson(Map<String, Object> json) {
    return FavoriteEntity.fromJson(json);
  }
}

/// @nodoc
const $FavoriteEntity = _$FavoriteEntityTearOff();

/// @nodoc
mixin _$FavoriteEntity {
  @JsonKey(name: 'institution_id')
  int get institutionId => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get image1 => throw _privateConstructorUsedError;
  String? get image2 => throw _privateConstructorUsedError;
  String? get image3 => throw _privateConstructorUsedError;
  String? get image4 => throw _privateConstructorUsedError;
  String? get image5 => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_user_ids')
  List<int> get userIds => throw _privateConstructorUsedError;
  List<String>? get images => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FavoriteEntityCopyWith<FavoriteEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteEntityCopyWith<$Res> {
  factory $FavoriteEntityCopyWith(
          FavoriteEntity value, $Res Function(FavoriteEntity) then) =
      _$FavoriteEntityCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'institution_id') int institutionId,
      String type,
      String name,
      String? image1,
      String? image2,
      String? image3,
      String? image4,
      String? image5,
      @JsonKey(name: 'end_user_ids') List<int> userIds,
      List<String>? images});
}

/// @nodoc
class _$FavoriteEntityCopyWithImpl<$Res>
    implements $FavoriteEntityCopyWith<$Res> {
  _$FavoriteEntityCopyWithImpl(this._value, this._then);

  final FavoriteEntity _value;
  // ignore: unused_field
  final $Res Function(FavoriteEntity) _then;

  @override
  $Res call({
    Object? institutionId = freezed,
    Object? type = freezed,
    Object? name = freezed,
    Object? image1 = freezed,
    Object? image2 = freezed,
    Object? image3 = freezed,
    Object? image4 = freezed,
    Object? image5 = freezed,
    Object? userIds = freezed,
    Object? images = freezed,
  }) {
    return _then(_value.copyWith(
      institutionId: institutionId == freezed
          ? _value.institutionId
          : institutionId // ignore: cast_nullable_to_non_nullable
              as int,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      image1: image1 == freezed
          ? _value.image1
          : image1 // ignore: cast_nullable_to_non_nullable
              as String?,
      image2: image2 == freezed
          ? _value.image2
          : image2 // ignore: cast_nullable_to_non_nullable
              as String?,
      image3: image3 == freezed
          ? _value.image3
          : image3 // ignore: cast_nullable_to_non_nullable
              as String?,
      image4: image4 == freezed
          ? _value.image4
          : image4 // ignore: cast_nullable_to_non_nullable
              as String?,
      image5: image5 == freezed
          ? _value.image5
          : image5 // ignore: cast_nullable_to_non_nullable
              as String?,
      userIds: userIds == freezed
          ? _value.userIds
          : userIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      images: images == freezed
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
abstract class _$FavoriteEntityCopyWith<$Res>
    implements $FavoriteEntityCopyWith<$Res> {
  factory _$FavoriteEntityCopyWith(
          _FavoriteEntity value, $Res Function(_FavoriteEntity) then) =
      __$FavoriteEntityCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'institution_id') int institutionId,
      String type,
      String name,
      String? image1,
      String? image2,
      String? image3,
      String? image4,
      String? image5,
      @JsonKey(name: 'end_user_ids') List<int> userIds,
      List<String>? images});
}

/// @nodoc
class __$FavoriteEntityCopyWithImpl<$Res>
    extends _$FavoriteEntityCopyWithImpl<$Res>
    implements _$FavoriteEntityCopyWith<$Res> {
  __$FavoriteEntityCopyWithImpl(
      _FavoriteEntity _value, $Res Function(_FavoriteEntity) _then)
      : super(_value, (v) => _then(v as _FavoriteEntity));

  @override
  _FavoriteEntity get _value => super._value as _FavoriteEntity;

  @override
  $Res call({
    Object? institutionId = freezed,
    Object? type = freezed,
    Object? name = freezed,
    Object? image1 = freezed,
    Object? image2 = freezed,
    Object? image3 = freezed,
    Object? image4 = freezed,
    Object? image5 = freezed,
    Object? userIds = freezed,
    Object? images = freezed,
  }) {
    return _then(_FavoriteEntity(
      institutionId: institutionId == freezed
          ? _value.institutionId
          : institutionId // ignore: cast_nullable_to_non_nullable
              as int,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      image1: image1 == freezed
          ? _value.image1
          : image1 // ignore: cast_nullable_to_non_nullable
              as String?,
      image2: image2 == freezed
          ? _value.image2
          : image2 // ignore: cast_nullable_to_non_nullable
              as String?,
      image3: image3 == freezed
          ? _value.image3
          : image3 // ignore: cast_nullable_to_non_nullable
              as String?,
      image4: image4 == freezed
          ? _value.image4
          : image4 // ignore: cast_nullable_to_non_nullable
              as String?,
      image5: image5 == freezed
          ? _value.image5
          : image5 // ignore: cast_nullable_to_non_nullable
              as String?,
      userIds: userIds == freezed
          ? _value.userIds
          : userIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      images: images == freezed
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FavoriteEntity
    with DiagnosticableTreeMixin
    implements _FavoriteEntity {
  const _$_FavoriteEntity(
      {@JsonKey(name: 'institution_id') required this.institutionId,
      required this.type,
      required this.name,
      this.image1,
      this.image2,
      this.image3,
      this.image4,
      this.image5,
      @JsonKey(name: 'end_user_ids') required this.userIds,
      this.images});

  factory _$_FavoriteEntity.fromJson(Map<String, dynamic> json) =>
      _$_$_FavoriteEntityFromJson(json);

  @override
  @JsonKey(name: 'institution_id')
  final int institutionId;
  @override
  final String type;
  @override
  final String name;
  @override
  final String? image1;
  @override
  final String? image2;
  @override
  final String? image3;
  @override
  final String? image4;
  @override
  final String? image5;
  @override
  @JsonKey(name: 'end_user_ids')
  final List<int> userIds;
  @override
  final List<String>? images;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FavoriteEntity(institutionId: $institutionId, type: $type, name: $name, image1: $image1, image2: $image2, image3: $image3, image4: $image4, image5: $image5, userIds: $userIds, images: $images)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FavoriteEntity'))
      ..add(DiagnosticsProperty('institutionId', institutionId))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('image1', image1))
      ..add(DiagnosticsProperty('image2', image2))
      ..add(DiagnosticsProperty('image3', image3))
      ..add(DiagnosticsProperty('image4', image4))
      ..add(DiagnosticsProperty('image5', image5))
      ..add(DiagnosticsProperty('userIds', userIds))
      ..add(DiagnosticsProperty('images', images));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FavoriteEntity &&
            (identical(other.institutionId, institutionId) ||
                const DeepCollectionEquality()
                    .equals(other.institutionId, institutionId)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.image1, image1) ||
                const DeepCollectionEquality().equals(other.image1, image1)) &&
            (identical(other.image2, image2) ||
                const DeepCollectionEquality().equals(other.image2, image2)) &&
            (identical(other.image3, image3) ||
                const DeepCollectionEquality().equals(other.image3, image3)) &&
            (identical(other.image4, image4) ||
                const DeepCollectionEquality().equals(other.image4, image4)) &&
            (identical(other.image5, image5) ||
                const DeepCollectionEquality().equals(other.image5, image5)) &&
            (identical(other.userIds, userIds) ||
                const DeepCollectionEquality()
                    .equals(other.userIds, userIds)) &&
            (identical(other.images, images) ||
                const DeepCollectionEquality().equals(other.images, images)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(institutionId) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(image1) ^
      const DeepCollectionEquality().hash(image2) ^
      const DeepCollectionEquality().hash(image3) ^
      const DeepCollectionEquality().hash(image4) ^
      const DeepCollectionEquality().hash(image5) ^
      const DeepCollectionEquality().hash(userIds) ^
      const DeepCollectionEquality().hash(images);

  @JsonKey(ignore: true)
  @override
  _$FavoriteEntityCopyWith<_FavoriteEntity> get copyWith =>
      __$FavoriteEntityCopyWithImpl<_FavoriteEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_FavoriteEntityToJson(this);
  }
}

abstract class _FavoriteEntity implements FavoriteEntity {
  const factory _FavoriteEntity(
      {@JsonKey(name: 'institution_id') required int institutionId,
      required String type,
      required String name,
      String? image1,
      String? image2,
      String? image3,
      String? image4,
      String? image5,
      @JsonKey(name: 'end_user_ids') required List<int> userIds,
      List<String>? images}) = _$_FavoriteEntity;

  factory _FavoriteEntity.fromJson(Map<String, dynamic> json) =
      _$_FavoriteEntity.fromJson;

  @override
  @JsonKey(name: 'institution_id')
  int get institutionId => throw _privateConstructorUsedError;
  @override
  String get type => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String? get image1 => throw _privateConstructorUsedError;
  @override
  String? get image2 => throw _privateConstructorUsedError;
  @override
  String? get image3 => throw _privateConstructorUsedError;
  @override
  String? get image4 => throw _privateConstructorUsedError;
  @override
  String? get image5 => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'end_user_ids')
  List<int> get userIds => throw _privateConstructorUsedError;
  @override
  List<String>? get images => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FavoriteEntityCopyWith<_FavoriteEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
