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

  void updateRate() async {
    try {
      var lastPriceBtc = await CoinData(btc, fiat).getCoinData();
      // var lastPriceEth = await CoinData(eth, fiat).getCoinData();
      // var lastPriceDoge = await CoinData(doge, fiat).getCoinData();
      setState(() {
        rateBtc = lastPriceBtc.toStringAsFixed(2);
        // rateEth = lastPriceEth.toStringAsFixed(2);
        // rateDoge = lastPriceDoge.toStringAsFixed(2);
      });
    } catch (e) {
      print(e);
    }
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
          Cards(coin: btc, coinRate: rateBtc, fiat: fiat),
          Cards(coin: eth, coinRate: rateEth, fiat: fiat),
          Cards(coin: doge, coinRate: rateDoge, fiat: fiat),
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
