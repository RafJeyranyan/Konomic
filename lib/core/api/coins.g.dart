// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coins.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coin _$CoinFromJson(Map<String, dynamic> json) => Coin(
      coinID: json['coinID'] as String?,
      coinImage: json['coinImage'] as String?,
      coinName: json['coinName'] as String?,
      coinShortName: json['coinShortName'] as String?,
      coinPrice: json['coinPrice'] as String?,
      coinLastPrice: json['coinLastPrice'] as String?,
      coinPercentage: json['coinPercentage'] as String?,
      coinSymbol: json['coinSymbol'] as String?,
      coinPairWith: json['coinPairWith'] as String?,
      coinHighDay: json['coinHighDay'] as String?,
      coinLowDay: json['coinLowDay'] as String?,
      coinDecimalPair: json['coinDecimalPair'] as int?,
      coinDecimalCurrency: json['coinDecimalCurrency'] as int?,
      coinListed: json['coinListed'] as bool?,
    );

Map<String, dynamic> _$CoinToJson(Coin instance) => <String, dynamic>{
      'coinID': instance.coinID,
      'coinImage': instance.coinImage,
      'coinName': instance.coinName,
      'coinShortName': instance.coinShortName,
      'coinPrice': instance.coinPrice,
      'coinLastPrice': instance.coinLastPrice,
      'coinPercentage': instance.coinPercentage,
      'coinSymbol': instance.coinSymbol,
      'coinPairWith': instance.coinPairWith,
      'coinHighDay': instance.coinHighDay,
      'coinLowDay': instance.coinLowDay,
      'coinDecimalPair': instance.coinDecimalPair,
      'coinDecimalCurrency': instance.coinDecimalCurrency,
      'coinListed': instance.coinListed,
    };
