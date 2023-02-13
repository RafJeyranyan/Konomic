import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konomic/view/coin_search.dart';
import 'package:konomic/view/home.dart';

import 'core/api/client.dart';
import 'core/api/coins.dart';
import 'cubits/main_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      // home:
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MainCubit(mainApi: MainApi(Dio())),
          )
        ],
        // child: KonanicScreen(),
        child: SafeArea(
          child: Scaffold(body:KonanicScreen()
           // CoinSearch(coinsList: coinsList , currencyList: currencyList, tickerList: tickerList, inrRate: 10,))
          )
        ),
      )
    );
  }
}

List<Coin> coinsList = [
  Coin(coinID: '1', coinImage: 'https://', coinName: 'Bitcoin', coinShortName: 'BTC', coinPrice: '123456', coinLastPrice: '123456', coinPercentage: '-0.5', coinSymbol: 'BTCUSDT', coinPairWith: 'USDT', coinHighDay: '567', coinLowDay: '12', coinDecimalPair: 3, coinDecimalCurrency: 4, coinListed: false),
  Coin(coinID: '2', coinImage: 'https://', coinName: 'Bitcoin', coinShortName: 'BTC', coinPrice: '123456', coinLastPrice: '123456', coinPercentage: '-0.5', coinSymbol: 'BTCINR', coinPairWith: 'INR', coinHighDay: '567', coinLowDay: '12', coinDecimalPair: 3, coinDecimalCurrency: 4, coinListed: false),
  Coin(coinID: '3', coinImage: 'https://', coinName: 'Binance USD', coinShortName: 'BUSD', coinPrice: '0.0005', coinLastPrice: '0.0005', coinPercentage: '-0.5', coinSymbol: 'BUSDBNB', coinPairWith: 'BNB', coinHighDay: '567', coinLowDay: '12', coinDecimalPair: 3, coinDecimalCurrency: 4, coinListed: false),
  Coin(coinID: '4', coinImage: 'https://', coinName: 'Dogecoin', coinShortName: 'DOGE', coinPrice: '123456', coinLastPrice: '123456', coinPercentage: '-0.5', coinSymbol: 'DOGEUSDT', coinPairWith: 'USDT', coinHighDay: '567', coinLowDay: '12', coinDecimalPair: 3, coinDecimalCurrency: 4, coinListed: false),
];

List<String> currencyList = [
  'USDT',
  'INR',
  'BNB',
];



List<String> tickerList = [
  "btcusdt@ticker",
  "ethusdt@ticker",
  "winusdt@ticker",
  "dentusdt@ticker",
  "xrpusdt@ticker",
  "etcusdt@ticker",
  "dogeusdt@ticker",
  "bnbusdt@ticker",
  "yfiusdt@ticker",
  "cakeusdt@ticker",
  "vetusdt@ticker",
  "maticusdt@ticker",
  "trxusdt@ticker",
  "eosusdt@ticker",
  "usdcusdt@ticker",
  "neoeth@ticker",
  "xmrbtc@ticker",
  "wintrx@ticker",
  "yfiiusdt@ticker",
  "aaveusdt@ticker",
  "dotusdt@ticker",
  "sandusdt@ticker",
  "maticbtc@ticker",
  "polybtc@ticker",
  "yfiibtc@ticker",
  "bnbbtc@ticker",
  "yfibtc@ticker",
  "aavebtc@ticker",
  "ltcbtc@ticker",
  "cakebtc@ticker",
  "eosbtc@ticker",
  "jstbtc@ticker",
  "chzbtc@ticker",
  "polybtc@ticker",
  "solbtc@ticker",
  "ksmbtc@ticker",
  "compbtc@ticker",
  "dashbtc@ticker",
  "axsbtc@ticker",
  "btgbtc@ticker",
  "lunabtc@ticker",
  "dasheth@ticker",
  "avaxeth@ticker",
  "axseth@ticker",
  "etceth@ticker",
  "doteth@ticker",
  "linketh@ticker",
  "omgeth@ticker",
  "sandeth@ticker",
  "waveseth@ticker",
  "nanoeth@ticker",
  "ezeth@ticker",
  "manaeth@ticker",
  "enjeth@ticker",
  "lsketh@ticker",
  "aaveeth@ticker",
  "mtleth@ticker",
  "adaeth@ticker",
  "iotaeth@ticker",
  "xrpeth@ticker",
  "shibusdt@ticker",
];