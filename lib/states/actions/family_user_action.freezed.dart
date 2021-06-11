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

  Update update(UserNicknameEntity user) {
    return Update(
      user,
    );
  }

  Delete delete(UserNicknameEntity user) {
    return Delete(
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
    required TResult Function(UserNicknameEntity user) update,
    required TResult Function(UserNicknameEntity user) delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(UserNicknameEntity user)? create,
    TResult Function(UserNicknameEntity user)? update,
    TResult Function(UserNicknameEntity user)? delete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Fetch value) fetch,
    required TResult Function(Create value) create,
    required TResult Function(Update value) update,
    required TResult Function(Delete value) delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Fetch value)? fetch,
    TResult Function(Create value)? create,
    TResult Function(Update value)? update,
    TResult Function(Delete value)? delete,
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
    required TResult Function(UserNicknameEntity user) update,
    required TResult Function(UserNicknameEntity user) delete,
  }) {
    return fetch();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(UserNicknameEntity user)? create,
    TResult Function(UserNicknameEntity user)? update,
    TResult Function(UserNicknameEntity user)? delete,
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
    required TResult Function(Update value) update,
    required TResult Function(Delete value) delete,
  }) {
    return fetch(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Fetch value)? fetch,
    TResult Function(Create value)? create,
    TResult Function(Update value)? update,
    TResult Function(Delete value)? delete,
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
    required TResult Function(UserNicknameEntity user) update,
    required TResult Function(UserNicknameEntity user) delete,
  }) {
    return create(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(UserNicknameEntity user)? create,
    TResult Function(UserNicknameEntity user)? update,
    TResult Function(UserNicknameEntity user)? delete,
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
    required TResult Function(Update value) update,
    required TResult Function(Delete value) delete,
  }) {
    return create(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Fetch value)? fetch,
    TResult Function(Create value)? create,
    TResult Function(Update value)? update,
    TResult Function(Delete value)? delete,
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

/// @nodoc
abstract class $UpdateCopyWith<$Res> {
  factory $UpdateCopyWith(Update value, $Res Function(Update) then) =
      _$UpdateCopyWithImpl<$Res>;
  $Res call({UserNicknameEntity user});

  $UserNicknameEntityCopyWith<$Res> get user;
}

/// @nodoc
class _$UpdateCopyWithImpl<$Res> extends _$FamilyUserActionCopyWithImpl<$Res>
    implements $UpdateCopyWith<$Res> {
  _$UpdateCopyWithImpl(Update _value, $Res Function(Update) _then)
      : super(_value, (v) => _then(v as Update));

  @override
  Update get _value => super._value as Update;

  @override
  $Res call({
    Object? user = freezed,
  }) {
    return _then(Update(
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

class _$Update with DiagnosticableTreeMixin implements Update {
  const _$Update(this.user);

  @override
  final UserNicknameEntity user;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FamilyUserAction.update(user: $user)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FamilyUserAction.update'))
      ..add(DiagnosticsProperty('user', user));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Update &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(user);

  @JsonKey(ignore: true)
  @override
  $UpdateCopyWith<Update> get copyWith =>
      _$UpdateCopyWithImpl<Update>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
    required TResult Function(UserNicknameEntity user) create,
    required TResult Function(UserNicknameEntity user) update,
    required TResult Function(UserNicknameEntity user) delete,
  }) {
    return update(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(UserNicknameEntity user)? create,
    TResult Function(UserNicknameEntity user)? update,
    TResult Function(UserNicknameEntity user)? delete,
    required TResult orElse(),
  }) {
    if (update != null) {
      return update(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Fetch value) fetch,
    required TResult Function(Create value) create,
    required TResult Function(Update value) update,
    required TResult Function(Delete value) delete,
  }) {
    return update(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Fetch value)? fetch,
    TResult Function(Create value)? create,
    TResult Function(Update value)? update,
    TResult Function(Delete value)? delete,
    required TResult orElse(),
  }) {
    if (update != null) {
      return update(this);
    }
    return orElse();
  }
}

abstract class Update implements FamilyUserAction {
  const factory Update(UserNicknameEntity user) = _$Update;

  UserNicknameEntity get user => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdateCopyWith<Update> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeleteCopyWith<$Res> {
  factory $DeleteCopyWith(Delete value, $Res Function(Delete) then) =
      _$DeleteCopyWithImpl<$Res>;
  $Res call({UserNicknameEntity user});

  $UserNicknameEntityCopyWith<$Res> get user;
}

/// @nodoc
class _$DeleteCopyWithImpl<$Res> extends _$FamilyUserActionCopyWithImpl<$Res>
    implements $DeleteCopyWith<$Res> {
  _$DeleteCopyWithImpl(Delete _value, $Res Function(Delete) _then)
      : super(_value, (v) => _then(v as Delete));

  @override
  Delete get _value => super._value as Delete;

  @override
  $Res call({
    Object? user = freezed,
  }) {
    return _then(Delete(
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

class _$Delete with DiagnosticableTreeMixin implements Delete {
  const _$Delete(this.user);

  @override
  final UserNicknameEntity user;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FamilyUserAction.delete(user: $user)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FamilyUserAction.delete'))
      ..add(DiagnosticsProperty('user', user));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Delete &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(user);

  @JsonKey(ignore: true)
  @override
  $DeleteCopyWith<Delete> get copyWith =>
      _$DeleteCopyWithImpl<Delete>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
    required TResult Function(UserNicknameEntity user) create,
    required TResult Function(UserNicknameEntity user) update,
    required TResult Function(UserNicknameEntity user) delete,
  }) {
    return delete(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(UserNicknameEntity user)? create,
    TResult Function(UserNicknameEntity user)? update,
    TResult Function(UserNicknameEntity user)? delete,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Fetch value) fetch,
    required TResult Function(Create value) create,
    required TResult Function(Update value) update,
    required TResult Function(Delete value) delete,
  }) {
    return delete(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Fetch value)? fetch,
    TResult Function(Create value)? create,
    TResult Function(Update value)? update,
    TResult Function(Delete value)? delete,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(this);
    }
    return orElse();
  }
}

abstract class Delete implements FamilyUserAction {
  const factory Delete(UserNicknameEntity user) = _$Delete;

  UserNicknameEntity get user => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeleteCopyWith<Delete> get copyWith => throw _privateConstructorUsedError;
}
