import 'package:get/get.dart';
import 'package:currency_converter/services/services.dart';

class CurrencyController extends GetxController {
  var isCurrencyLoading = false.obs;
  var convertedStrValue = '0.0'.obs;

  void fetchCurrency(double value, String baseCurrency, String targetCurrency) async {
    try {
      isCurrencyLoading(true);
      var newValue = await (Services.fetchCurrencyData(baseCurrency, targetCurrency));
      newValue = newValue * value;
      String a = '$newValue $targetCurrency';
      convertedStrValue = RxString(a);
    } finally {
      isCurrencyLoading(false);
    }
  }
}