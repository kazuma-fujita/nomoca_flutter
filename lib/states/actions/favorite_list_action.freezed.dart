// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'favorite_list_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$FavoriteListActionTearOff {
  const _$FavoriteListActionTearOff();

  FetchList fetchList() {
    return const FetchList();
  }
}

/// @nodoc
const $FavoriteListAction = _$FavoriteListActionTearOff();

/// @nodoc
mixin _$FavoriteListAction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchList,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchList value) fetchList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchList value)? fetchList,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteListActionCopyWith<$Res> {
  factory $FavoriteListActionCopyWith(
          FavoriteListAction value, $Res Function(FavoriteListAction) then) =
      _$FavoriteListActionCopyWithImpl<$Res>;
}

/// @nodoc
class _$FavoriteListActionCopyWithImpl<$Res>
    implements $FavoriteListActionCopyWith<$Res> {
  _$FavoriteListActionCopyWithImpl(this._value, this._then);

  final FavoriteListAction _value;
  // ignore: unused_field
  final $Res Function(FavoriteListAction) _then;
}

/// @nodoc
abstract class $FetchListCopyWith<$Res> {
  factory $FetchListCopyWith(FetchList value, $Res Function(FetchList) then) =
      _$FetchListCopyWithImpl<$Res>;
}

/// @nodoc
class _$FetchListCopyWithImpl<$Res>
    extends _$FavoriteListActionCopyWithImpl<$Res>
    implements $FetchListCopyWith<$Res> {
  _$FetchListCopyWithImpl(FetchList _value, $Res Function(FetchList) _then)
      : super(_value, (v) => _then(v as FetchList));

  @override
  FetchList get _value => super._value as FetchList;
}

/// @nodoc

class _$FetchList with DiagnosticableTreeMixin implements FetchList {
  const _$FetchList();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FavoriteListAction.fetchList()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FavoriteListAction.fetchList'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is FetchList);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchList,
  }) {
    return fetchList();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchList,
    required TResult orElse(),
  }) {
    if (fetchList != null) {
      return fetchList();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchList value) fetchList,
  }) {
    return fetchList(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchList value)? fetchList,
    required TResult orElse(),
  }) {
    if (fetchList != null) {
      return fetchList(this);
    }
    return orElse();
  }
}

abstract class FetchList implements FavoriteListAction {
  const factory FetchList() = _$FetchList;
}
