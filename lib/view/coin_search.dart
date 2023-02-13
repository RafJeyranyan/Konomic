import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konomic/cubits/main_cubit.dart';
import '../core/api/coins.dart';

class CoinSearch extends StatefulWidget {
  final List<Coin> coinsList;
  final List<String> currencyList;
  final List<String> tickerList;
  final double inrRate;

  /// coins list
  final bool? showCoinImage;
  final BorderRadius? cardPercentageBorder;
  final double? cardPercentageHeight;
  final double? cardPercentageWidth;
  final Function(BuildContext, Coin)? onSearchCoinTap;

  const CoinSearch({
    Key? key,
    required this.coinsList,
    required this.currencyList,
    required this.tickerList,
    required this.inrRate,
    this.showCoinImage = true,
    this.cardPercentageBorder,
    this.cardPercentageHeight,
    this.cardPercentageWidth,
    this.onSearchCoinTap,
  }) : super(key: key);

  @override
  State<CoinSearch> createState() => _CoinSearchState();
}

class _CoinSearchState extends State<CoinSearch> {
  bool isDark = false;

  bool sortList = false;

  ///search
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  bool _isSearching = false;
  String _searchText = "";

  _CoinSearchState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  ///

  @override
  void initState() {
    context.read<MainCubit>().getCoins(widget.coinsList, widget.tickerList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context).brightness == Brightness.dark
        ? isDark = true
        : isDark = false;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: height * 0.03,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: height * 0.05,
              width: width * 0.9,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey, width: 1)),
              child: TextFormField(
                controller: _searchQuery,
                onChanged: (newValue) {
                  _searchText = newValue;
                },
                //autofocus: widget.details['autoFocus'],
                decoration: InputDecoration(
                    filled: false,
                    border: InputBorder.none,
                    hintText: 'Search coins',
                    contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 10)),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: height * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      context.read<MainCubit>().allCoinsList.sort((a, b) {
                        if (a.coinName != null && b.coinName != null) {
                          return a.coinName!
                              .toLowerCase()
                              .compareTo(b.coinName!.toLowerCase());
                        }
                        return 0;
                      });
                      sortList = false;
                    });
                  },
                  child: SizedBox(
                      width: width * 0.38,
                      child: Text(
                        'Coin Name',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      context.read<MainCubit>().allCoinsList.sort((a, b) {
                        if (a.coinName != null && b.coinName != null) {
                          return double.parse(a.coinPrice!)
                              .compareTo(double.parse(b.coinPrice!));
                        }
                        return 0;
                      });
                      sortList = false;
                    });
                  },
                  child: SizedBox(
                    width: width * 0.22,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Price',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        Icon(
                          Icons.arrow_upward_sharp,
                          size: 14,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                    child: Text(
                  '24H Change',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                )),
              ],
            ),
          ),
          _isSearching
              ? _buildSearchList(context.read<MainCubit>().allCoinsList)
              : SizedBox(
                  height: height * 0.8,
                  child: ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: height * 0.01),
                      physics: const BouncingScrollPhysics(),
                      itemCount: context.read<MainCubit>().allCoinsList.length,
                      itemBuilder: (context, index) {
                        return itemsCard(index,
                            context.read<MainCubit>().allCoinsList[index]);
                      }),
                ),
        ],
      )),
    );
  }

  /// coins card
  Widget itemsCard(index, Coin coin) {
    double oldPrice = coin.coinLastPrice != null
        ? double.parse(coin.coinPrice ?? "")
        : double.parse(coin.coinLastPrice ?? "");
    coin.coinLastPrice = coin.coinPrice;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        InkWell(
          onTap: () {
            // widget.onSearchCoinTap!(context, coin);
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: height * 0.003),
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: height * 0.014),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.network(
                      coin.coinImage ?? "",
                      height: width * 0.085,
                      width: width * 0.085,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: width * 0.083,
                        width: width * 0.083,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.grey.shade400, width: 1)),
                        child: Center(
                          child: Text(coin.coinName ?? '-'
                              // : coin.coinName[0]
                              ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.014,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width * 0.24,
                          child: Row(
                            children: [
                              Text(
                                "${coin.coinShortName} / ",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                coin.coinPairWith ?? "",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        Text(
                          coin.coinName ?? "",
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: width * 0.22,
                  child: Text(
                      context.watch<MainCubit>().state.allCoinsList[index]
                          .coinPairWith?.toLowerCase() == 'inr'
                        ? (double.parse(context.watch<MainCubit>().state.allCoinsList[index].coinPrice.toString()) *
                                widget.inrRate)
                            .toStringAsFixed(context.watch<MainCubit>().state.allCoinsList[index].coinDecimalPair ?? 0)
                        : double.parse(context.watch<MainCubit>().state.allCoinsList[index].coinPrice.toString())
                            .toStringAsFixed(coin.coinDecimalPair ?? 0),
                    textAlign: TextAlign.end,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 12,
                      color: double.parse(coin.coinPrice ?? "") > oldPrice
                          ? Colors.lightGreen
                          : double.parse(coin.coinPrice ?? "") < oldPrice
                              ? Colors.red
                              : Colors.red,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  width: widget.cardPercentageWidth ?? width * 0.16,
                  height: widget.cardPercentageHeight ?? height * 0.025,
                  decoration: BoxDecoration(
                    color: coin.coinPercentage.toString().startsWith('-')
                        ? Colors.red
                        : Colors.lightGreen,
                    borderRadius:
                        widget.cardPercentageBorder ?? BorderRadius.circular(0),
                  ),
                  padding: const EdgeInsets.all(2),
                  child: Center(
                      child: FittedBox(
                          child: Text(
                    '${coin.coinPercentage}%',
                    style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ))),
                  //child: Text(percent + '%', style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w700),),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  ///search
  Widget _buildSearchList(allCoinList) {
    if (_searchText.isEmpty) {
      _isSearching = false;

      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: allCoinList.length,
            itemBuilder: (BuildContext context, index) {
              return itemsCard(index, allCoinList);
            }),
      );
    } else {
      _isSearching = true;

      List<Coin> searchList = allCoinList
          .where((item) =>
              item.coinName
                  .toString()
                  .toLowerCase()
                  .contains(_searchText.toString().toLowerCase()) ||
              item.coinShortName
                  .toString()
                  .toLowerCase()
                  .contains(_searchText.toString().toLowerCase()))
          .toList();

      return searchList.isEmpty
          ? Center(
              child: Text(
              'Item Not Found',
            ))
          : SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: searchList.length,
                  itemBuilder: (BuildContext context, index) {
                    return searchItemsCard(index, searchList[index]);
                  }),
            );
    }
  }

  ///

  /// search item card
  Widget searchItemsCard(index, Coin coin) {
    double oldPrice = coin.coinLastPrice != null
        ? double.parse(coin.coinPrice ?? "0")
        : double.parse(coin.coinLastPrice ?? "0");
    coin.coinLastPrice = coin.coinPrice;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        InkWell(
          onTap: () {
            // widget.onSearchCoinTap!(context, coin);
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: height * 0.003),
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: height * 0.014),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.network(
                      coin.coinImage ?? "",
                      height: width * 0.085,
                      width: width * 0.085,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: width * 0.083,
                        width: width * 0.083,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.grey.shade400, width: 1)),
                        child: Center(
                          child: Text(coin.coinName ?? '-'
                              // : coin.coinName[0]
                              ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.014,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width * 0.24,
                          child: Row(
                            children: [
                              Text(
                                "${coin.coinShortName} / ",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                coin.coinPairWith ?? "",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        Text(
                          coin.coinName ?? "",
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: width * 0.22,
                  child: Text(
                    coin.coinPairWith?.toLowerCase() == 'inr'
                        ? (double.parse(coin.coinPrice.toString()) *
                                widget.inrRate)
                            .toStringAsFixed(coin.coinDecimalPair ?? 0)
                        : double.parse(coin.coinPrice.toString())
                            .toStringAsFixed(coin.coinDecimalPair ?? 0),
                    textAlign: TextAlign.end,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 12,
                      color: double.parse(coin.coinPrice ?? "0") > oldPrice
                          ? Colors.lightGreen
                          : double.parse(coin.coinPrice ?? "0") < oldPrice
                              ? Colors.red
                              : Colors.red,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  width: widget.cardPercentageWidth ?? width * 0.16,
                  height: widget.cardPercentageHeight ?? height * 0.025,
                  decoration: BoxDecoration(
                    color: coin.coinPercentage.toString().startsWith('-')
                        ? Colors.red
                        : Colors.lightGreen,
                    borderRadius:
                        widget.cardPercentageBorder ?? BorderRadius.circular(0),
                  ),
                  padding: const EdgeInsets.all(2),
                  child: Center(
                      child: FittedBox(
                          child: Text(
                    '${coin.coinPercentage}%',
                    style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ))),
                  //child: Text(percent + '%', style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w700),),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  ///
}
