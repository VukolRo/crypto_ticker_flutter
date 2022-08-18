import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'cards.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String rateBtc = '0';
  String rateEth = '0';
  String rateDoge = '0';
  String? fiat = 'USD';
  String btc = 'BTC';
  String eth = 'ETH';
  String doge = 'DOGE';
  List<String> coinDataList = currenciesList;
  bool isWaiting = true;
  Map<String, String> coinValue = {};

  void updateRate() async {
    isWaiting = true;
    try {
      var data = await CoinData().getCoinData(fiat);
      isWaiting = false;
      setState(() {
        coinValue = data;
      });
    } catch (e) {
      print(e);
    }
  }

  Column makeCards() {
    List<Cards> criptoCards = [];
    for (String coin in cryptoList) {
      criptoCards.add(
        Cards(
            coin: coin,
            coinRate: isWaiting ? '?' : coinValue[coin],
            fiat: fiat),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: criptoCards,
    );
  }

  @override
  void initState() {
    super.initState();
    updateRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          makeCards(),
          Expanded(child: Container()),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.indigo,
            child: DropdownButton(
              value: fiat,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.white),
              onChanged: (String? newValue) {
                setState(() {
                  fiat = newValue;
                  updateRate();
                });
              },
              items: coinDataList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
