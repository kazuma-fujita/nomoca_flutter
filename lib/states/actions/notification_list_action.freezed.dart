// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'notification_list_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$NotificationListActionTearOff {
  const _$NotificationListActionTearOff();

  FetchList fetchList() {
    return const FetchList();
  }

  IsRead isRead(int notificationId) {
    return IsRead(
      notificationId,
    );
  }
}

/// @nodoc
const $NotificationListAction = _$NotificationListActionTearOff();

/// @nodoc
mixin _$NotificationListAction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchList,
    required TResult Function(int notificationId) isRead,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchList,
    TResult Function(int notificationId)? isRead,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchList value) fetchList,
    required TResult Function(IsRead value) isRead,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchList value)? fetchList,
    TResult Function(IsRead value)? isRead,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationListActionCopyWith<$Res> {
  factory $NotificationListActionCopyWith(NotificationListAction value,
          $Res Function(NotificationListAction) then) =
      _$NotificationListActionCopyWithImpl<$Res>;
}

/// @nodoc
class _$NotificationListActionCopyWithImpl<$Res>
    implements $NotificationListActionCopyWith<$Res> {
  _$NotificationListActionCopyWithImpl(this._value, this._then);

  final NotificationListAction _value;
  // ignore: unused_field
  final $Res Function(NotificationListAction) _then;
}

/// @nodoc
abstract class $FetchListCopyWith<$Res> {
  factory $FetchListCopyWith(FetchList value, $Res Function(FetchList) then) =
      _$FetchListCopyWithImpl<$Res>;
}

/// @nodoc
class _$FetchListCopyWithImpl<$Res>
    extends _$NotificationListActionCopyWithImpl<$Res>
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
    return 'NotificationListAction.fetchList()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NotificationListAction.fetchList'));
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
    required TResult Function(int notificationId) isRead,
  }) {
    return fetchList();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchList,
    TResult Function(int notificationId)? isRead,
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
    required TResult Function(IsRead value) isRead,
  }) {
    return fetchList(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchList value)? fetchList,
    TResult Function(IsRead value)? isRead,
    required TResult orElse(),
  }) {
    if (fetchList != null) {
      return fetchList(this);
    }
    return orElse();
  }
}

abstract class FetchList implements NotificationListAction {
  const factory FetchList() = _$FetchList;
}

/// @nodoc
abstract class $IsReadCopyWith<$Res> {
  factory $IsReadCopyWith(IsRead value, $Res Function(IsRead) then) =
      _$IsReadCopyWithImpl<$Res>;
  $Res call({int notificationId});
}

/// @nodoc
class _$IsReadCopyWithImpl<$Res>
    extends _$NotificationListActionCopyWithImpl<$Res>
    implements $IsReadCopyWith<$Res> {
  _$IsReadCopyWithImpl(IsRead _value, $Res Function(IsRead) _then)
      : super(_value, (v) => _then(v as IsRead));

  @override
  IsRead get _value => super._value as IsRead;

  @override
  $Res call({
    Object? notificationId = freezed,
  }) {
    return _then(IsRead(
      notificationId == freezed
          ? _value.notificationId
          : notificationId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$IsRead with DiagnosticableTreeMixin implements IsRead {
  const _$IsRead(this.notificationId);

  @override
  final int notificationId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NotificationListAction.isRead(notificationId: $notificationId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NotificationListAction.isRead'))
      ..add(DiagnosticsProperty('notificationId', notificationId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is IsRead &&
            (identical(other.notificationId, notificationId) ||
                const DeepCollectionEquality()
                    .equals(other.notificationId, notificationId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(notificationId);

  @JsonKey(ignore: true)
  @override
  $IsReadCopyWith<IsRead> get copyWith =>
      _$IsReadCopyWithImpl<IsRead>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchList,
    required TResult Function(int notificationId) isRead,
  }) {
    return isRead(notificationId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchList,
    TResult Function(int notificationId)? isRead,
    required TResult orElse(),
  }) {
    if (isRead != null) {
      return isRead(notificationId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchList value) fetchList,
    required TResult Function(IsRead value) isRead,
  }) {
    return isRead(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchList value)? fetchList,
    TResult Function(IsRead value)? isRead,
    required TResult orElse(),
  }) {
    if (isRead != null) {
      return isRead(this);
    }
    return orElse();
  }
}

abstract class IsRead implements NotificationListAction {
  const factory IsRead(int notificationId) = _$IsRead;

  int get notificationId => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IsReadCopyWith<IsRead> get copyWith => throw _privateConstructorUsedError;
}
