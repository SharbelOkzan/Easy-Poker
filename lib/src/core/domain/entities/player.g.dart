// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayerImpl _$$PlayerImplFromJson(Map<String, dynamic> json) => _$PlayerImpl(
      id: $enumDecode(_$PlayerIdEnumMap, json['id']),
      cards: (json['cards'] as List<dynamic>)
          .map((e) => Card.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PlayerImplToJson(_$PlayerImpl instance) =>
    <String, dynamic>{
      'id': _$PlayerIdEnumMap[instance.id]!,
      'cards': instance.cards.map((e) => e.toJson()).toList(),
    };

const _$PlayerIdEnumMap = {
  PlayerId.p1: 'p1',
  PlayerId.p2: 'p2',
};
