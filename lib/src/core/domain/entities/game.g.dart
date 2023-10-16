// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameImpl _$$GameImplFromJson(Map<String, dynamic> json) => _$GameImpl(
      player1: Player.fromJson(json['player1'] as Map<String, dynamic>),
      player2: Player.fromJson(json['player2'] as Map<String, dynamic>),
      deck: (json['deck'] as List<dynamic>)
          .map((e) => Card.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: GameStatus.fromJson(json['status'] as Map<String, dynamic>),
      selectedCardsForExchangeIndecies:
          (json['selectedCardsForExchangeIndecies'] as List<dynamic>)
              .map((e) => e as int)
              .toList(),
    );

Map<String, dynamic> _$$GameImplToJson(_$GameImpl instance) =>
    <String, dynamic>{
      'player1': instance.player1,
      'player2': instance.player2,
      'deck': instance.deck,
      'status': instance.status,
      'selectedCardsForExchangeIndecies':
          instance.selectedCardsForExchangeIndecies,
    };
