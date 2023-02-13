// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coins.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coins _$CoinsFromJson(Map<String, dynamic> json) => Coins(
      id: json['id'] as String?,
      name: json['name'] as String?,
      symbol: json['symbol'] as String?,
    );

Map<String, dynamic> _$CoinsToJson(Coins instance) => <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'name': instance.name,
    };
