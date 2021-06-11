// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'family_user_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$FamilyUserActionTearOff {
  const _$FamilyUserActionTearOff();

  Fetch fetch() {
    return const Fetch();
  }

  Create create(UserNicknameEntity user) {
    return Create(
      user,
    );
  }
}

/// @nodoc
const $FamilyUserAction = _$FamilyUserActionTearOff();

/// @nodoc
mixin _$FamilyUserAction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
    required TResult Function(UserNicknameEntity user) create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(UserNicknameEntity user)? create,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Fetch value) fetch,
    required TResult Function(Create value) create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Fetch value)? fetch,
    TResult Function(Create value)? create,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FamilyUserActionCopyWith<$Res> {
  factory $FamilyUserActionCopyWith(
          FamilyUserAction value, $Res Function(FamilyUserAction) then) =
      _$FamilyUserActionCopyWithImpl<$Res>;
}

/// @nodoc
class _$FamilyUserActionCopyWithImpl<$Res>
    implements $FamilyUserActionCopyWith<$Res> {
  _$FamilyUserActionCopyWithImpl(this._value, this._then);

  final FamilyUserAction _value;
  // ignore: unused_field
  final $Res Function(FamilyUserAction) _then;
}

/// @nodoc
abstract class $FetchCopyWith<$Res> {
  factory $FetchCopyWith(Fetch value, $Res Function(Fetch) then) =
      _$FetchCopyWithImpl<$Res>;
}

/// @nodoc
class _$FetchCopyWithImpl<$Res> extends _$FamilyUserActionCopyWithImpl<$Res>
    implements $FetchCopyWith<$Res> {
  _$FetchCopyWithImpl(Fetch _value, $Res Function(Fetch) _then)
      : super(_value, (v) => _then(v as Fetch));

  @override
  Fetch get _value => super._value as Fetch;
}

/// @nodoc

class _$Fetch with DiagnosticableTreeMixin implements Fetch {
  const _$Fetch();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FamilyUserAction.fetch()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'FamilyUserAction.fetch'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Fetch);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
    required TResult Function(UserNicknameEntity user) create,
  }) {
    return fetch();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(UserNicknameEntity user)? create,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Fetch value) fetch,
    required TResult Function(Create value) create,
  }) {
    return fetch(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Fetch value)? fetch,
    TResult Function(Create value)? create,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(this);
    }
    return orElse();
  }
}

abstract class Fetch implements FamilyUserAction {
  const factory Fetch() = _$Fetch;
}

/// @nodoc
abstract class $CreateCopyWith<$Res> {
  factory $CreateCopyWith(Create value, $Res Function(Create) then) =
      _$CreateCopyWithImpl<$Res>;
  $Res call({UserNicknameEntity user});

  $UserNicknameEntityCopyWith<$Res> get user;
}

/// @nodoc
class _$CreateCopyWithImpl<$Res> extends _$FamilyUserActionCopyWithImpl<$Res>
    implements $CreateCopyWith<$Res> {
  _$CreateCopyWithImpl(Create _value, $Res Function(Create) _then)
      : super(_value, (v) => _then(v as Create));

  @override
  Create get _value => super._value as Create;

  @override
  $Res call({
    Object? user = freezed,
  }) {
    return _then(Create(
      user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserNicknameEntity,
    ));
  }

  @override
  $UserNicknameEntityCopyWith<$Res> get user {
    return $UserNicknameEntityCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$Create with DiagnosticableTreeMixin implements Create {
  const _$Create(this.user);

  @override
  final UserNicknameEntity user;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FamilyUserAction.create(user: $user)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FamilyUserAction.create'))
      ..add(DiagnosticsProperty('user', user));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Create &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(user);

  @JsonKey(ignore: true)
  @override
  $CreateCopyWith<Create> get copyWith =>
      _$CreateCopyWithImpl<Create>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
    required TResult Function(UserNicknameEntity user) create,
  }) {
    return create(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(UserNicknameEntity user)? create,
    required TResult orElse(),
  }) {
    if (create != null) {
      return create(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Fetch value) fetch,
    required TResult Function(Create value) create,
  }) {
    return create(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Fetch value)? fetch,
    TResult Function(Create value)? create,
    required TResult orElse(),
  }) {
    if (create != null) {
      return create(this);
    }
    return orElse();
  }
}

abstract class Create implements FamilyUserAction {
  const factory Create(UserNicknameEntity user) = _$Create;

  UserNicknameEntity get user => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateCopyWith<Create> get copyWith => throw _privateConstructorUsedError;
}
