// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Game _$GameFromJson(Map<String, dynamic> json) {
  return _Game.fromJson(json);
}

/// @nodoc
mixin _$Game {
  Player get player1 => throw _privateConstructorUsedError;
  Player get player2 => throw _privateConstructorUsedError;
  List<Card> get deck => throw _privateConstructorUsedError;
  GameStatus get status => throw _privateConstructorUsedError;
  List<int> get selectedCardsForExchangeIndecies =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameCopyWith<Game> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameCopyWith<$Res> {
  factory $GameCopyWith(Game value, $Res Function(Game) then) =
      _$GameCopyWithImpl<$Res, Game>;
  @useResult
  $Res call(
      {Player player1,
      Player player2,
      List<Card> deck,
      GameStatus status,
      List<int> selectedCardsForExchangeIndecies});

  $PlayerCopyWith<$Res> get player1;
  $PlayerCopyWith<$Res> get player2;
}

/// @nodoc
class _$GameCopyWithImpl<$Res, $Val extends Game>
    implements $GameCopyWith<$Res> {
  _$GameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player1 = null,
    Object? player2 = null,
    Object? deck = null,
    Object? status = null,
    Object? selectedCardsForExchangeIndecies = null,
  }) {
    return _then(_value.copyWith(
      player1: null == player1
          ? _value.player1
          : player1 // ignore: cast_nullable_to_non_nullable
              as Player,
      player2: null == player2
          ? _value.player2
          : player2 // ignore: cast_nullable_to_non_nullable
              as Player,
      deck: null == deck
          ? _value.deck
          : deck // ignore: cast_nullable_to_non_nullable
              as List<Card>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GameStatus,
      selectedCardsForExchangeIndecies: null == selectedCardsForExchangeIndecies
          ? _value.selectedCardsForExchangeIndecies
          : selectedCardsForExchangeIndecies // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PlayerCopyWith<$Res> get player1 {
    return $PlayerCopyWith<$Res>(_value.player1, (value) {
      return _then(_value.copyWith(player1: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PlayerCopyWith<$Res> get player2 {
    return $PlayerCopyWith<$Res>(_value.player2, (value) {
      return _then(_value.copyWith(player2: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameImplCopyWith<$Res> implements $GameCopyWith<$Res> {
  factory _$$GameImplCopyWith(
          _$GameImpl value, $Res Function(_$GameImpl) then) =
      __$$GameImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Player player1,
      Player player2,
      List<Card> deck,
      GameStatus status,
      List<int> selectedCardsForExchangeIndecies});

  @override
  $PlayerCopyWith<$Res> get player1;
  @override
  $PlayerCopyWith<$Res> get player2;
}

/// @nodoc
class __$$GameImplCopyWithImpl<$Res>
    extends _$GameCopyWithImpl<$Res, _$GameImpl>
    implements _$$GameImplCopyWith<$Res> {
  __$$GameImplCopyWithImpl(_$GameImpl _value, $Res Function(_$GameImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player1 = null,
    Object? player2 = null,
    Object? deck = null,
    Object? status = null,
    Object? selectedCardsForExchangeIndecies = null,
  }) {
    return _then(_$GameImpl(
      player1: null == player1
          ? _value.player1
          : player1 // ignore: cast_nullable_to_non_nullable
              as Player,
      player2: null == player2
          ? _value.player2
          : player2 // ignore: cast_nullable_to_non_nullable
              as Player,
      deck: null == deck
          ? _value._deck
          : deck // ignore: cast_nullable_to_non_nullable
              as List<Card>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GameStatus,
      selectedCardsForExchangeIndecies: null == selectedCardsForExchangeIndecies
          ? _value._selectedCardsForExchangeIndecies
          : selectedCardsForExchangeIndecies // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameImpl extends _Game {
  _$GameImpl(
      {required this.player1,
      required this.player2,
      required final List<Card> deck,
      required this.status,
      required final List<int> selectedCardsForExchangeIndecies})
      : _deck = deck,
        _selectedCardsForExchangeIndecies = selectedCardsForExchangeIndecies,
        super._();

  factory _$GameImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameImplFromJson(json);

  @override
  final Player player1;
  @override
  final Player player2;
  final List<Card> _deck;
  @override
  List<Card> get deck {
    if (_deck is EqualUnmodifiableListView) return _deck;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deck);
  }

  @override
  final GameStatus status;
  final List<int> _selectedCardsForExchangeIndecies;
  @override
  List<int> get selectedCardsForExchangeIndecies {
    if (_selectedCardsForExchangeIndecies is EqualUnmodifiableListView)
      return _selectedCardsForExchangeIndecies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedCardsForExchangeIndecies);
  }

  @override
  String toString() {
    return 'Game(player1: $player1, player2: $player2, deck: $deck, status: $status, selectedCardsForExchangeIndecies: $selectedCardsForExchangeIndecies)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameImpl &&
            (identical(other.player1, player1) || other.player1 == player1) &&
            (identical(other.player2, player2) || other.player2 == player2) &&
            const DeepCollectionEquality().equals(other._deck, _deck) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(
                other._selectedCardsForExchangeIndecies,
                _selectedCardsForExchangeIndecies));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      player1,
      player2,
      const DeepCollectionEquality().hash(_deck),
      status,
      const DeepCollectionEquality().hash(_selectedCardsForExchangeIndecies));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameImplCopyWith<_$GameImpl> get copyWith =>
      __$$GameImplCopyWithImpl<_$GameImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameImplToJson(
      this,
    );
  }
}

abstract class _Game extends Game {
  factory _Game(
      {required final Player player1,
      required final Player player2,
      required final List<Card> deck,
      required final GameStatus status,
      required final List<int> selectedCardsForExchangeIndecies}) = _$GameImpl;
  _Game._() : super._();

  factory _Game.fromJson(Map<String, dynamic> json) = _$GameImpl.fromJson;

  @override
  Player get player1;
  @override
  Player get player2;
  @override
  List<Card> get deck;
  @override
  GameStatus get status;
  @override
  List<int> get selectedCardsForExchangeIndecies;
  @override
  @JsonKey(ignore: true)
  _$$GameImplCopyWith<_$GameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
