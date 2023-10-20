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
      phase: GamePhase.fromJson(json['phase'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GameImplToJson(_$GameImpl instance) =>
    <String, dynamic>{
      'player1': instance.player1.toJson(),
      'player2': instance.player2.toJson(),
      'deck': instance.deck.map((e) => e.toJson()).toList(),
      'phase': instance.phase.toJson(),
    };
