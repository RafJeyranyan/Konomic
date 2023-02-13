import 'package:dio/dio.dart';
import 'package:konomic/core/api/coins.dart';

Future<List<Coins>> getCoins () async{
  final dio = Dio();
  print("object");
  final result = await dio.get("https://www.coingecko.com/en/api/coins/list");
  List<Coins> coins = [];
  final data = result.data as List;
  for (int i = 0; i < data.length; i++){
    coins.add(Coins.fromJson(data[i]));
  }
  print(coins.length);
  return coins;
}