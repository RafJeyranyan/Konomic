import 'package:json_annotation/json_annotation.dart';

part 'coins.g.dart';

@JsonSerializable()
class Coins {
  String? id;
  String? symbol;
  String? name;

  Coins({this.id,this.name,this.symbol});

  factory Coins.fromJson(Map<String, dynamic> json) =>
      _$CoinsFromJson(json);

  Map<String, dynamic> toJson() => _$CoinsToJson(this);
}