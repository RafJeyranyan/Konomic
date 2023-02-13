import 'package:konomic/configs.dart';
import 'package:konomic/core/api/coins.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'client.g.dart';


@RestApi(baseUrl: baseUrl)
abstract class MainApi {
  factory MainApi(Dio dio) = _MainApi;

  // USER

  @GET("/coins")
  Future<List<Coins>> getCoins();

}