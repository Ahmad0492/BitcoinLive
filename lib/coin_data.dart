import 'dart:convert';
import 'package:http/http.dart' as http;

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
];

class CoinData {
  Future getCoinData(String cryptoSymbol, String selectedCurrency) async {
    String apiUrl =
        'https://rest.coinapi.io/v1/exchangerate/$cryptoSymbol/$selectedCurrency?apikey=CB3FF184-5AEC-491C-BE88-3EA322E51AFB';
    http.Response response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      var btcToselectedCurrency = data['rate'];
      return btcToselectedCurrency;
    } else {
      throw Exception('Failed to load exchange rate: ${response.statusCode}');
    }
  }
}
