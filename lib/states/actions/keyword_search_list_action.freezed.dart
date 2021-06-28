// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'keyword_search_list_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$KeywordSearchListActionTearOff {
  const _$KeywordSearchListActionTearOff();

  FetchList fetchList(
      {required String query,
      required int offset,
      required int limit,
      double? latitude,
      double? longitude}) {
    return FetchList(
      query: query,
      offset: offset,
      limit: limit,
      latitude: latitude,
      longitude: longitude,
    );
  }

  ToggleFavorite toggleFavorite(int institutionId) {
    return ToggleFavorite(
      institutionId,
    );
  }

  None none() {
    return const None();
  }
}

/// @nodoc
const $KeywordSearchListAction = _$KeywordSearchListActionTearOff();

/// @nodoc
mixin _$KeywordSearchListAction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query, int offset, int limit,
            double? latitude, double? longitude)
        fetchList,
    required TResult Function(int institutionId) toggleFavorite,
    required TResult Function() none,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query, int offset, int limit, double? latitude,
            double? longitude)?
        fetchList,
    TResult Function(int institutionId)? toggleFavorite,
    TResult Function()? none,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchList value) fetchList,
    required TResult Function(ToggleFavorite value) toggleFavorite,
    required TResult Function(None value) none,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchList value)? fetchList,
    TResult Function(ToggleFavorite value)? toggleFavorite,
    TResult Function(None value)? none,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeywordSearchListActionCopyWith<$Res> {
  factory $KeywordSearchListActionCopyWith(KeywordSearchListAction value,
          $Res Function(KeywordSearchListAction) then) =
      _$KeywordSearchListActionCopyWithImpl<$Res>;
}

/// @nodoc
class _$KeywordSearchListActionCopyWithImpl<$Res>
    implements $KeywordSearchListActionCopyWith<$Res> {
  _$KeywordSearchListActionCopyWithImpl(this._value, this._then);

  final KeywordSearchListAction _value;
  // ignore: unused_field
  final $Res Function(KeywordSearchListAction) _then;
}

/// @nodoc
abstract class $FetchListCopyWith<$Res> {
  factory $FetchListCopyWith(FetchList value, $Res Function(FetchList) then) =
      _$FetchListCopyWithImpl<$Res>;
  $Res call(
      {String query,
      int offset,
      int limit,
      double? latitude,
      double? longitude});
}

/// @nodoc
class _$FetchListCopyWithImpl<$Res>
    extends _$KeywordSearchListActionCopyWithImpl<$Res>
    implements $FetchListCopyWith<$Res> {
  _$FetchListCopyWithImpl(FetchList _value, $Res Function(FetchList) _then)
      : super(_value, (v) => _then(v as FetchList));

  @override
  FetchList get _value => super._value as FetchList;

  @override
  $Res call({
    Object? query = freezed,
    Object? offset = freezed,
    Object? limit = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(FetchList(
      query: query == freezed
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      offset: offset == freezed
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      limit: limit == freezed
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      latitude: latitude == freezed
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: longitude == freezed
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$FetchList with DiagnosticableTreeMixin implements FetchList {
  const _$FetchList(
      {required this.query,
      required this.offset,
      required this.limit,
      this.latitude,
      this.longitude});

  @override
  final String query;
  @override
  final int offset;
  @override
  final int limit;
  @override
  final double? latitude;
  @override
  final double? longitude;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'KeywordSearchListAction.fetchList(query: $query, offset: $offset, limit: $limit, latitude: $latitude, longitude: $longitude)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'KeywordSearchListAction.fetchList'))
      ..add(DiagnosticsProperty('query', query))
      ..add(DiagnosticsProperty('offset', offset))
      ..add(DiagnosticsProperty('limit', limit))
      ..add(DiagnosticsProperty('latitude', latitude))
      ..add(DiagnosticsProperty('longitude', longitude));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FetchList &&
            (identical(other.query, query) ||
                const DeepCollectionEquality().equals(other.query, query)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.latitude, latitude) ||
                const DeepCollectionEquality()
                    .equals(other.latitude, latitude)) &&
            (identical(other.longitude, longitude) ||
                const DeepCollectionEquality()
                    .equals(other.longitude, longitude)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(query) ^
      const DeepCollectionEquality().hash(offset) ^
      const DeepCollectionEquality().hash(limit) ^
      const DeepCollectionEquality().hash(latitude) ^
      const DeepCollectionEquality().hash(longitude);

  @JsonKey(ignore: true)
  @override
  $FetchListCopyWith<FetchList> get copyWith =>
      _$FetchListCopyWithImpl<FetchList>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query, int offset, int limit,
            double? latitude, double? longitude)
        fetchList,
    required TResult Function(int institutionId) toggleFavorite,
    required TResult Function() none,
  }) {
    return fetchList(query, offset, limit, latitude, longitude);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query, int offset, int limit, double? latitude,
            double? longitude)?
        fetchList,
    TResult Function(int institutionId)? toggleFavorite,
    TResult Function()? none,
    required TResult orElse(),
  }) {
    if (fetchList != null) {
      return fetchList(query, offset, limit, latitude, longitude);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchList value) fetchList,
    required TResult Function(ToggleFavorite value) toggleFavorite,
    required TResult Function(None value) none,
  }) {
    return fetchList(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchList value)? fetchList,
    TResult Function(ToggleFavorite value)? toggleFavorite,
    TResult Function(None value)? none,
    required TResult orElse(),
  }) {
    if (fetchList != null) {
      return fetchList(this);
    }
    return orElse();
  }
}

abstract class FetchList implements KeywordSearchListAction {
  const factory FetchList(
      {required String query,
      required int offset,
      required int limit,
      double? latitude,
      double? longitude}) = _$FetchList;

  String get query => throw _privateConstructorUsedError;
  int get offset => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FetchListCopyWith<FetchList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ToggleFavoriteCopyWith<$Res> {
  factory $ToggleFavoriteCopyWith(
          ToggleFavorite value, $Res Function(ToggleFavorite) then) =
      _$ToggleFavoriteCopyWithImpl<$Res>;
  $Res call({int institutionId});
}

/// @nodoc
class _$ToggleFavoriteCopyWithImpl<$Res>
    extends _$KeywordSearchListActionCopyWithImpl<$Res>
    implements $ToggleFavoriteCopyWith<$Res> {
  _$ToggleFavoriteCopyWithImpl(
      ToggleFavorite _value, $Res Function(ToggleFavorite) _then)
      : super(_value, (v) => _then(v as ToggleFavorite));

  @override
  ToggleFavorite get _value => super._value as ToggleFavorite;

  @override
  $Res call({
    Object? institutionId = freezed,
  }) {
    return _then(ToggleFavorite(
      institutionId == freezed
          ? _value.institutionId
          : institutionId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ToggleFavorite with DiagnosticableTreeMixin implements ToggleFavorite {
  const _$ToggleFavorite(this.institutionId);

  @override
  final int institutionId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'KeywordSearchListAction.toggleFavorite(institutionId: $institutionId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
          DiagnosticsProperty('type', 'KeywordSearchListAction.toggleFavorite'))
      ..add(DiagnosticsProperty('institutionId', institutionId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ToggleFavorite &&
            (identical(other.institutionId, institutionId) ||
                const DeepCollectionEquality()
                    .equals(other.institutionId, institutionId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(institutionId);

  @JsonKey(ignore: true)
  @override
  $ToggleFavoriteCopyWith<ToggleFavorite> get copyWith =>
      _$ToggleFavoriteCopyWithImpl<ToggleFavorite>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query, int offset, int limit,
            double? latitude, double? longitude)
        fetchList,
    required TResult Function(int institutionId) toggleFavorite,
    required TResult Function() none,
  }) {
    return toggleFavorite(institutionId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query, int offset, int limit, double? latitude,
            double? longitude)?
        fetchList,
    TResult Function(int institutionId)? toggleFavorite,
    TResult Function()? none,
    required TResult orElse(),
  }) {
    if (toggleFavorite != null) {
      return toggleFavorite(institutionId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchList value) fetchList,
    required TResult Function(ToggleFavorite value) toggleFavorite,
    required TResult Function(None value) none,
  }) {
    return toggleFavorite(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchList value)? fetchList,
    TResult Function(ToggleFavorite value)? toggleFavorite,
    TResult Function(None value)? none,
    required TResult orElse(),
  }) {
    if (toggleFavorite != null) {
      return toggleFavorite(this);
    }
    return orElse();
  }
}

abstract class ToggleFavorite implements KeywordSearchListAction {
  const factory ToggleFavorite(int institutionId) = _$ToggleFavorite;

  int get institutionId => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ToggleFavoriteCopyWith<ToggleFavorite> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoneCopyWith<$Res> {
  factory $NoneCopyWith(None value, $Res Function(None) then) =
      _$NoneCopyWithImpl<$Res>;
}

/// @nodoc
class _$NoneCopyWithImpl<$Res>
    extends _$KeywordSearchListActionCopyWithImpl<$Res>
    implements $NoneCopyWith<$Res> {
  _$NoneCopyWithImpl(None _value, $Res Function(None) _then)
      : super(_value, (v) => _then(v as None));

  @override
  None get _value => super._value as None;
}

/// @nodoc

class _$None with DiagnosticableTreeMixin implements None {
  const _$None();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'KeywordSearchListAction.none()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'KeywordSearchListAction.none'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is None);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query, int offset, int limit,
            double? latitude, double? longitude)
        fetchList,
    required TResult Function(int institutionId) toggleFavorite,
    required TResult Function() none,
  }) {
    return none();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query, int offset, int limit, double? latitude,
            double? longitude)?
        fetchList,
    TResult Function(int institutionId)? toggleFavorite,
    TResult Function()? none,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchList value) fetchList,
    required TResult Function(ToggleFavorite value) toggleFavorite,
    required TResult Function(None value) none,
  }) {
    return none(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchList value)? fetchList,
    TResult Function(ToggleFavorite value)? toggleFavorite,
    TResult Function(None value)? none,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none(this);
    }
    return orElse();
  }
}

abstract class None implements KeywordSearchListAction {
  const factory None() = _$None;
}
