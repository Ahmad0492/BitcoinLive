import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  Map<String, String> cryptoRates = {
    'BTC': '?',
    'ETH': '?',
    'LTC': '?',
  };

  @override
  void initState() {
    super.initState();
    getExchangeRate();
  }

  void getExchangeRate() async {
    try {
      for (String crypto in cryptoList) {
        double data = await CoinData().getCoinData(crypto, selectedCurrency);
        setState(() {
          cryptoRates[crypto] = data.toStringAsFixed(2);
        });
      }
    } catch (e) {
      throw Exception('Exception while loading exchange rate: $e');
    }
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      dropDownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getExchangeRate(); // Call the method to fetch updated exchange rate
        });
      },
      children: pickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent, // Set background color
          centerTitle: true, // Center the title text
          title: const Text('🤑 Coin Ticker'), // Title text
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  CryptoCard(
                    cryptoCurrency: 'BTC',
                    selectedCurrency: selectedCurrency,
                    rate: cryptoRates['BTC']!,
                  ),
                  CryptoCard(
                    cryptoCurrency: 'ETH',
                    selectedCurrency: selectedCurrency,
                    rate: cryptoRates['ETH']!,
                  ),
                  CryptoCard(
                    cryptoCurrency: 'LTC',
                    selectedCurrency: selectedCurrency,
                    rate: cryptoRates['LTC']!,
                  ),
                ],
              ),
            ),
            Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: iOSPicker(),
            ),
          ],
        ),
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    super.key,
    required this.cryptoCurrency,
    required this.selectedCurrency,
    required this.rate,
  });

  final String cryptoCurrency;
  final String selectedCurrency;
  final String rate;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $cryptoCurrency = $rate $selectedCurrency',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
