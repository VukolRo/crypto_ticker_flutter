import 'package:http/http.dart' as http;
import 'dart:convert';

const String kApiKey = '7E0831B6-98A0-4130-941C-63B3C9E9C05A';
const String urlAuthority = 'rest.coinapi.io';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
  'BNB',
];

class CoinData {
  Future getCoinData(String? fiat) async {
    Map<String, String> cryptoPrices = {};
    for (String coin in cryptoList) {
      String urlUnencodedPath = 'v1/exchangerate/$coin/$fiat';
      final url = Uri.https(urlAuthority, urlUnencodedPath, {
        'apikey': kApiKey,
      });
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        String data = response.body;
        double lastPrice = jsonDecode(data)['rate'];
        cryptoPrices[coin] = lastPrice.toStringAsFixed(2);
      } else {
        print('error ${response.statusCode}');
      }
    }
    return cryptoPrices;
  }
}
