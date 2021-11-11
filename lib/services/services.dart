import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:currency_converter/constants.dart';

class Services {
  static var client = http.Client();
  //https://freecurrencyapi.net/api/v2/latest?apikey=4501f560-424b-11ec-96dd-23862cb51fef&base_currency=TRY
  static Future fetchCurrencyData(String baseCurrency, String targetCurrency) async {
    //print('Base Currency: $baseCurrency');
    var response = await http
        .get(Uri.parse('https://freecurrencyapi.net/api/v2/latest?apikey=$myApiKey&base_currency=$baseCurrency'));
    //print('Status Code: ${response.statusCode}');
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      double targetValue = jsonData['data'][targetCurrency];
      //print(targetValue);
      return targetValue;
    } else {
      print('Error in fetching Currencies');
      return null;
    }
  }
}