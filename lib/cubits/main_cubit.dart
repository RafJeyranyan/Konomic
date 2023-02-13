import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../core/api/client.dart';
import '../core/api/coins.dart';

class MainCubit extends Cubit<MainState> {
  final MainApi mainApi;

  MainCubit({
    required this.mainApi,
  }) : super(MainState(
    stage: MainStateStage.loading, allCoinsList: [],

  ));

  List<Coin> allCoinsList = <Coin>[];

  var selectedTabIndex = 1;


  getCoins(List<Coin> coinsList,  List<String> tickerList) async {
    allCoinsList = coinsList;
    emit(state.copyWith(stage: MainStateStage.display,allCoinsList: allCoinsList));
    connectToServer(tickerList);
    // update();
    // emit(state.copyWith(stage: MainStateStage.display,allCoinsList: allCoinsList));
  }


  var selectedCurrency = '';
  List selectedCurrencyCoins = [];


  getSelectCurrencyList(String currencyName) async {
    if(selectedCurrency.isEmpty) {

      selectedCurrency = currencyName;

      for (int i = 0; i < allCoinsList.length; i++) {
        String?  currencyName = allCoinsList.elementAt(i).coinPairWith;
        if (currencyName?.toLowerCase() == selectedCurrency.toLowerCase()) {
          selectedCurrencyCoins.add(Coin(
            coinID: allCoinsList.elementAt(i).coinID,
            coinImage: allCoinsList.elementAt(i).coinImage,
            coinName: allCoinsList.elementAt(i).coinName,
            coinShortName: allCoinsList.elementAt(i).coinShortName,
            coinPrice: allCoinsList.elementAt(i).coinPrice,
            coinLastPrice: allCoinsList.elementAt(i).coinLastPrice,
            coinPercentage: allCoinsList.elementAt(i).coinPercentage,
            coinSymbol: allCoinsList.elementAt(i).coinSymbol,
            coinPairWith: allCoinsList.elementAt(i).coinPairWith,
            coinHighDay: allCoinsList.elementAt(i).coinHighDay,
            coinLowDay: allCoinsList.elementAt(i).coinLowDay,
            coinDecimalPair: allCoinsList.elementAt(i).coinDecimalPair,
            coinDecimalCurrency: allCoinsList.elementAt(i).coinDecimalCurrency,
            coinListed: allCoinsList.elementAt(i).coinListed,
          ));
        }
      }
    }
    else {

      selectedCurrency = currencyName;
      selectedCurrencyCoins.clear();
      for (int i = 0; i < allCoinsList.length; i++) {
        String? currencyName = allCoinsList.elementAt(i).coinPairWith;
        if (currencyName?.toLowerCase() == selectedCurrency.toLowerCase()) {
          selectedCurrencyCoins.add(Coin(
            coinID: allCoinsList.elementAt(i).coinID,
            coinImage: allCoinsList.elementAt(i).coinImage,
            coinName: allCoinsList.elementAt(i).coinName,
            coinShortName: allCoinsList.elementAt(i).coinShortName,
            coinPrice: allCoinsList.elementAt(i).coinPrice,
            coinLastPrice: allCoinsList.elementAt(i).coinPrice,
            coinPercentage: allCoinsList.elementAt(i).coinPercentage,
            coinSymbol: allCoinsList.elementAt(i).coinSymbol,
            coinPairWith: allCoinsList.elementAt(i).coinPairWith,
            coinHighDay: allCoinsList.elementAt(i).coinHighDay,
            coinLowDay: allCoinsList.elementAt(i).coinLowDay,
            coinDecimalPair: allCoinsList.elementAt(i).coinDecimalPair,
            coinDecimalCurrency: allCoinsList.elementAt(i).coinDecimalCurrency,
            coinListed: allCoinsList.elementAt(i).coinListed,
          ));
        }
      }
    }

    // emit(state.copyWith(stage: MainStateStage.display,allCoinsList: allCoinsList));

  }



  connectToServer(tickerList) {
    WebSocketChannel channelHome = IOWebSocketChannel.connect(Uri.parse('wss://stream.binance.com:9443/ws/stream?'),);

    var subRequestHome = {
      'method': "SUBSCRIBE",
      'params': tickerList,
      'id': 1,
    };

    var jsonString = json.encode(subRequestHome);
    channelHome.sink.add(jsonString);
    var result = channelHome.stream.transform(
      StreamTransformer<dynamic, dynamic>.fromHandlers(
        handleData: (number, sink) {
          sink.add(number);
        },
      ),
    );
    result.listen((event) {
      var snapshot = jsonDecode(event);
      // print("${snapshot['s'].toString()}, ${snapshot['c'].toString()}, ${snapshot['P'].toString()}");
      updateCoin(snapshot['s'].toString(), snapshot['c'].toString(), snapshot['P'].toString());
    });
  }

  void updateCoin(String coinSymbol, String coinPrice, String coinPercentage) async {

    var inrPairCoins = coinSymbol.substring(0, coinSymbol.length - 4);

    allCoinsList.indexWhere((element) => element.coinSymbol?.toUpperCase() == coinSymbol.toUpperCase());

    var index = allCoinsList.indexWhere((element) => element.coinSymbol?.toUpperCase() == coinSymbol.toUpperCase() || element.coinSymbol?.toUpperCase() == '${inrPairCoins.toUpperCase()}INR');
    var selectedCurrencyIndex = selectedCurrencyCoins.indexWhere((element) => element.coinSymbol.toUpperCase() == coinSymbol.toUpperCase() || element.coinSymbol.toUpperCase() == '${inrPairCoins.toUpperCase()}INR');


    if(index >= 0) {
      allCoinsList.elementAt(index).coinPrice = coinPrice;
      allCoinsList.elementAt(index).coinPercentage = coinPercentage;
    }

    if(selectedCurrencyIndex >= 0) {
      selectedCurrencyCoins.elementAt(selectedCurrencyIndex).coinPrice = coinPrice;
      selectedCurrencyCoins.elementAt(selectedCurrencyIndex).coinPercentage = coinPercentage;
    }



    emit(state.copyWith(stage: MainStateStage.display,allCoinsList: state.allCoinsList, updated: !state.updated));
  }
}


enum MainStateStage {
  loading,
  display,
}

class MainState extends Equatable {
  final List<Coin> allCoinsList;
  final MainStateStage stage;
  final bool updated;

  MainState({required this.allCoinsList,required this.stage, this.updated = false});

  MainState copyWith({
    MainStateStage? stage,
    List<Coin>? allCoinsList,
    bool? updated,
  }) {
    return MainState(
      stage: stage ?? this.stage,
      allCoinsList: allCoinsList ?? this.allCoinsList,
      updated: updated ?? this.updated,



    );
  }

  @override
  List<Object?> get props => [allCoinsList, stage, updated];
}
