import 'package:json_annotation/json_annotation.dart';

part 'coins.g.dart';

@JsonSerializable()
class Coin {

  String? coinID;
  String? coinImage;
  String? coinName;
  String? coinShortName;
  String? coinPrice;
  String? coinLastPrice;
  String? coinPercentage;
  String? coinSymbol;
  String? coinPairWith;
  String? coinHighDay;
  String? coinLowDay;
  int? coinDecimalPair;
  int? coinDecimalCurrency;
  bool? coinListed;

  Coin({
    this.coinID,
    this.coinImage,
    this.coinName,
    this.coinShortName,
    this.coinPrice,
    this.coinLastPrice,
    this.coinPercentage,
    this.coinSymbol,
    this.coinPairWith,
    this.coinHighDay,
    this.coinLowDay,
    this.coinDecimalPair,
    this.coinDecimalCurrency,
    this.coinListed,
  });

factory Coin.fromJson(Map<String, dynamic> json) =>
    _$CoinFromJson(json);

Map<String, dynamic> toJson() => _$CoinToJson(this);

  @override
  String toString() {
    return 'Coin{coinID: $coinID, coinImage: $coinImage, coinName: $coinName, coinShortName: $coinShortName, coinPrice: $coinPrice, coinLastPrice: $coinLastPrice, coinPercentage: $coinPercentage, coinSymbol: $coinSymbol, coinPairWith: $coinPairWith, coinHighDay: $coinHighDay, coinLowDay: $coinLowDay, coinDecimalPair: $coinDecimalPair, coinDecimalCurrency: $coinDecimalCurrency, coinListed: $coinListed}';
  }
}