import 'package:get/get.dart';
import 'package:currency_converter/services/services.dart';

class ConverterController extends GetxController {
  var isCurrencyLoading = false.obs;
  var convertedStrValue = '0.0'.obs;

  void fetchCurrency(double value, String baseCurrency, String targetCurrency) async {
    try {
      isCurrencyLoading(true);
      var newValue = await (Services.fetchCurrencyData(baseCurrency, targetCurrency));

      newValue = newValue * value;
      var roundedStrValue = newValue.toStringAsFixed(2);

      String a = '$roundedStrValue $targetCurrency';

      convertedStrValue = RxString(a);
    } finally {
      isCurrencyLoading(false);
    }
  }
}