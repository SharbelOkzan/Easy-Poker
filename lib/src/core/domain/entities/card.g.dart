// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CardImpl _$$CardImplFromJson(Map<String, dynamic> json) => _$CardImpl(
      suit: $enumDecode(_$CardSuitEnumMap, json['suit']),
      index: $enumDecode(_$CardIndexEnumMap, json['index']),
    );

Map<String, dynamic> _$$CardImplToJson(_$CardImpl instance) =>
    <String, dynamic>{
      'suit': _$CardSuitEnumMap[instance.suit]!,
      'index': _$CardIndexEnumMap[instance.index]!,
    };

const _$CardSuitEnumMap = {
  CardSuit.clubs: 'clubs',
  CardSuit.hearts: 'hearts',
  CardSuit.spades: 'spades',
  CardSuit.pip: 'pip',
};

const _$CardIndexEnumMap = {
  CardIndex.two: 'two',
  CardIndex.three: 'three',
  CardIndex.four: 'four',
  CardIndex.five: 'five',
  CardIndex.six: 'six',
  CardIndex.seven: 'seven',
  CardIndex.eight: 'eight',
  CardIndex.nine: 'nine',
  CardIndex.ten: 'ten',
  CardIndex.jack: 'jack',
  CardIndex.queen: 'queen',
  CardIndex.king: 'king',
  CardIndex.ace: 'ace',
};
