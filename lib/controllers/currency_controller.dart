import 'package:get/get.dart';
import 'package:currency_converter/services/services.dart';

class CurrencyController extends GetxController {
  var isCurrencyLoading = false.obs;
  var convertedEurStrValue = '0.0'.obs;
  var convertedUsdStrValue = '0.0'.obs;
  var baseCurrency = 'RUB'.obs;

  @override
  void onInit() {
    fetchCurrency('RUB');
    super.onInit();
  }
  void fetchCurrency(String baseCurrency) async {
    try {
      isCurrencyLoading(true);
      var valueList = await (Services.fetchCurrencyUsdEurData(baseCurrency));

      final roundedEurStrValue = valueList[0].toStringAsFixed(2);
      final roundedUsdStrValue = valueList[1].toStringAsFixed(2);

      convertedEurStrValue = RxString(roundedEurStrValue);
      convertedUsdStrValue = RxString(roundedUsdStrValue);
    } finally {
      isCurrencyLoading(false);
    }
  }
}