// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'notification_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NotificationEntity _$NotificationEntityFromJson(Map<String, dynamic> json) {
  return _NotificationEntity.fromJson(json);
}

/// @nodoc
class _$NotificationEntityTearOff {
  const _$NotificationEntityTearOff();

  _NotificationEntity call(
      {required int id,
      @JsonKey(name: 'is_read') required bool isRead,
      @JsonKey(name: 'notify') required NotificationDetailEntity detail}) {
    return _NotificationEntity(
      id: id,
      isRead: isRead,
      detail: detail,
    );
  }

  NotificationEntity fromJson(Map<String, Object> json) {
    return NotificationEntity.fromJson(json);
  }
}

/// @nodoc
const $NotificationEntity = _$NotificationEntityTearOff();

/// @nodoc
mixin _$NotificationEntity {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_read')
  bool get isRead => throw _privateConstructorUsedError;
  @JsonKey(name: 'notify')
  NotificationDetailEntity get detail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationEntityCopyWith<NotificationEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationEntityCopyWith<$Res> {
  factory $NotificationEntityCopyWith(
          NotificationEntity value, $Res Function(NotificationEntity) then) =
      _$NotificationEntityCopyWithImpl<$Res>;
  $Res call(
      {int id,
      @JsonKey(name: 'is_read') bool isRead,
      @JsonKey(name: 'notify') NotificationDetailEntity detail});

  $NotificationDetailEntityCopyWith<$Res> get detail;
}

/// @nodoc
class _$NotificationEntityCopyWithImpl<$Res>
    implements $NotificationEntityCopyWith<$Res> {
  _$NotificationEntityCopyWithImpl(this._value, this._then);

  final NotificationEntity _value;
  // ignore: unused_field
  final $Res Function(NotificationEntity) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? isRead = freezed,
    Object? detail = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      isRead: isRead == freezed
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      detail: detail == freezed
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as NotificationDetailEntity,
    ));
  }

  @override
  $NotificationDetailEntityCopyWith<$Res> get detail {
    return $NotificationDetailEntityCopyWith<$Res>(_value.detail, (value) {
      return _then(_value.copyWith(detail: value));
    });
  }
}

/// @nodoc
abstract class _$NotificationEntityCopyWith<$Res>
    implements $NotificationEntityCopyWith<$Res> {
  factory _$NotificationEntityCopyWith(
          _NotificationEntity value, $Res Function(_NotificationEntity) then) =
      __$NotificationEntityCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      @JsonKey(name: 'is_read') bool isRead,
      @JsonKey(name: 'notify') NotificationDetailEntity detail});

  @override
  $NotificationDetailEntityCopyWith<$Res> get detail;
}

/// @nodoc
class __$NotificationEntityCopyWithImpl<$Res>
    extends _$NotificationEntityCopyWithImpl<$Res>
    implements _$NotificationEntityCopyWith<$Res> {
  __$NotificationEntityCopyWithImpl(
      _NotificationEntity _value, $Res Function(_NotificationEntity) _then)
      : super(_value, (v) => _then(v as _NotificationEntity));

  @override
  _NotificationEntity get _value => super._value as _NotificationEntity;

  @override
  $Res call({
    Object? id = freezed,
    Object? isRead = freezed,
    Object? detail = freezed,
  }) {
    return _then(_NotificationEntity(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      isRead: isRead == freezed
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      detail: detail == freezed
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as NotificationDetailEntity,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NotificationEntity
    with DiagnosticableTreeMixin
    implements _NotificationEntity {
  const _$_NotificationEntity(
      {required this.id,
      @JsonKey(name: 'is_read') required this.isRead,
      @JsonKey(name: 'notify') required this.detail});

  factory _$_NotificationEntity.fromJson(Map<String, dynamic> json) =>
      _$_$_NotificationEntityFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'is_read')
  final bool isRead;
  @override
  @JsonKey(name: 'notify')
  final NotificationDetailEntity detail;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NotificationEntity(id: $id, isRead: $isRead, detail: $detail)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NotificationEntity'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('isRead', isRead))
      ..add(DiagnosticsProperty('detail', detail));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NotificationEntity &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.isRead, isRead) ||
                const DeepCollectionEquality().equals(other.isRead, isRead)) &&
            (identical(other.detail, detail) ||
                const DeepCollectionEquality().equals(other.detail, detail)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(isRead) ^
      const DeepCollectionEquality().hash(detail);

  @JsonKey(ignore: true)
  @override
  _$NotificationEntityCopyWith<_NotificationEntity> get copyWith =>
      __$NotificationEntityCopyWithImpl<_NotificationEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_NotificationEntityToJson(this);
  }
}

abstract class _NotificationEntity implements NotificationEntity {
  const factory _NotificationEntity(
          {required int id,
          @JsonKey(name: 'is_read') required bool isRead,
          @JsonKey(name: 'notify') required NotificationDetailEntity detail}) =
      _$_NotificationEntity;

  factory _NotificationEntity.fromJson(Map<String, dynamic> json) =
      _$_NotificationEntity.fromJson;

  @override
  int get id => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'is_read')
  bool get isRead => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'notify')
  NotificationDetailEntity get detail => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$NotificationEntityCopyWith<_NotificationEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationDetailEntity _$NotificationDetailEntityFromJson(
    Map<String, dynamic> json) {
  return _NotificationDetailEntity.fromJson(json);
}

/// @nodoc
class _$NotificationDetailEntityTearOff {
  const _$NotificationDetailEntityTearOff();

  _NotificationDetailEntity call(
      {required String title,
      required String body,
      required String contributor,
      @JsonKey(name: 'send_at') required String deliveryDate,
      @JsonKey(name: 'image1') required String? imageUrl}) {
    return _NotificationDetailEntity(
      title: title,
      body: body,
      contributor: contributor,
      deliveryDate: deliveryDate,
      imageUrl: imageUrl,
    );
  }

  NotificationDetailEntity fromJson(Map<String, Object> json) {
    return NotificationDetailEntity.fromJson(json);
  }
}

/// @nodoc
const $NotificationDetailEntity = _$NotificationDetailEntityTearOff();

/// @nodoc
mixin _$NotificationDetailEntity {
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  String get contributor => throw _privateConstructorUsedError;
  @JsonKey(name: 'send_at')
  String get deliveryDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'image1')
  String? get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationDetailEntityCopyWith<NotificationDetailEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationDetailEntityCopyWith<$Res> {
  factory $NotificationDetailEntityCopyWith(NotificationDetailEntity value,
          $Res Function(NotificationDetailEntity) then) =
      _$NotificationDetailEntityCopyWithImpl<$Res>;
  $Res call(
      {String title,
      String body,
      String contributor,
      @JsonKey(name: 'send_at') String deliveryDate,
      @JsonKey(name: 'image1') String? imageUrl});
}

/// @nodoc
class _$NotificationDetailEntityCopyWithImpl<$Res>
    implements $NotificationDetailEntityCopyWith<$Res> {
  _$NotificationDetailEntityCopyWithImpl(this._value, this._then);

  final NotificationDetailEntity _value;
  // ignore: unused_field
  final $Res Function(NotificationDetailEntity) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? body = freezed,
    Object? contributor = freezed,
    Object? deliveryDate = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: body == freezed
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      contributor: contributor == freezed
          ? _value.contributor
          : contributor // ignore: cast_nullable_to_non_nullable
              as String,
      deliveryDate: deliveryDate == freezed
          ? _value.deliveryDate
          : deliveryDate // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$NotificationDetailEntityCopyWith<$Res>
    implements $NotificationDetailEntityCopyWith<$Res> {
  factory _$NotificationDetailEntityCopyWith(_NotificationDetailEntity value,
          $Res Function(_NotificationDetailEntity) then) =
      __$NotificationDetailEntityCopyWithImpl<$Res>;
  @override
  $Res call(
      {String title,
      String body,
      String contributor,
      @JsonKey(name: 'send_at') String deliveryDate,
      @JsonKey(name: 'image1') String? imageUrl});
}

/// @nodoc
class __$NotificationDetailEntityCopyWithImpl<$Res>
    extends _$NotificationDetailEntityCopyWithImpl<$Res>
    implements _$NotificationDetailEntityCopyWith<$Res> {
  __$NotificationDetailEntityCopyWithImpl(_NotificationDetailEntity _value,
      $Res Function(_NotificationDetailEntity) _then)
      : super(_value, (v) => _then(v as _NotificationDetailEntity));

  @override
  _NotificationDetailEntity get _value =>
      super._value as _NotificationDetailEntity;

  @override
  $Res call({
    Object? title = freezed,
    Object? body = freezed,
    Object? contributor = freezed,
    Object? deliveryDate = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_NotificationDetailEntity(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: body == freezed
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      contributor: contributor == freezed
          ? _value.contributor
          : contributor // ignore: cast_nullable_to_non_nullable
              as String,
      deliveryDate: deliveryDate == freezed
          ? _value.deliveryDate
          : deliveryDate // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NotificationDetailEntity
    with DiagnosticableTreeMixin
    implements _NotificationDetailEntity {
  const _$_NotificationDetailEntity(
      {required this.title,
      required this.body,
      required this.contributor,
      @JsonKey(name: 'send_at') required this.deliveryDate,
      @JsonKey(name: 'image1') required this.imageUrl});

  factory _$_NotificationDetailEntity.fromJson(Map<String, dynamic> json) =>
      _$_$_NotificationDetailEntityFromJson(json);

  @override
  final String title;
  @override
  final String body;
  @override
  final String contributor;
  @override
  @JsonKey(name: 'send_at')
  final String deliveryDate;
  @override
  @JsonKey(name: 'image1')
  final String? imageUrl;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NotificationDetailEntity(title: $title, body: $body, contributor: $contributor, deliveryDate: $deliveryDate, imageUrl: $imageUrl)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NotificationDetailEntity'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('body', body))
      ..add(DiagnosticsProperty('contributor', contributor))
      ..add(DiagnosticsProperty('deliveryDate', deliveryDate))
      ..add(DiagnosticsProperty('imageUrl', imageUrl));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NotificationDetailEntity &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.body, body) ||
                const DeepCollectionEquality().equals(other.body, body)) &&
            (identical(other.contributor, contributor) ||
                const DeepCollectionEquality()
                    .equals(other.contributor, contributor)) &&
            (identical(other.deliveryDate, deliveryDate) ||
                const DeepCollectionEquality()
                    .equals(other.deliveryDate, deliveryDate)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(body) ^
      const DeepCollectionEquality().hash(contributor) ^
      const DeepCollectionEquality().hash(deliveryDate) ^
      const DeepCollectionEquality().hash(imageUrl);

  @JsonKey(ignore: true)
  @override
  _$NotificationDetailEntityCopyWith<_NotificationDetailEntity> get copyWith =>
      __$NotificationDetailEntityCopyWithImpl<_NotificationDetailEntity>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_NotificationDetailEntityToJson(this);
  }
}

abstract class _NotificationDetailEntity implements NotificationDetailEntity {
  const factory _NotificationDetailEntity(
          {required String title,
          required String body,
          required String contributor,
          @JsonKey(name: 'send_at') required String deliveryDate,
          @JsonKey(name: 'image1') required String? imageUrl}) =
      _$_NotificationDetailEntity;

  factory _NotificationDetailEntity.fromJson(Map<String, dynamic> json) =
      _$_NotificationDetailEntity.fromJson;

  @override
  String get title => throw _privateConstructorUsedError;
  @override
  String get body => throw _privateConstructorUsedError;
  @override
  String get contributor => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'send_at')
  String get deliveryDate => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'image1')
  String? get imageUrl => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$NotificationDetailEntityCopyWith<_NotificationDetailEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
