import 'package:get/get.dart';
import 'package:currency_converter/services/services.dart';

class CurrencyController extends GetxController {
  var isCurrencyLoading = false.obs;
  var convertedEurStrValue = '0.0'.obs;
  var convertedUsdStrValue = '0.0'.obs;
  var convertedRubStrValue = '0.0'.obs;
  var baseCurrency = 'TJS'.obs;

  @override
  void onInit() {
    fetchCurrency('TJS');
    super.onInit();
  }
  void fetchCurrency(String baseCurrency) async {
    try {
      isCurrencyLoading(true);
      var valueList = await (Services.fetchCurrencyUsdEurData(baseCurrency));

      final eur100 = valueList[0] * 100;
      final usd100 = valueList[1] * 100;
      final rub1000 = valueList[2] * 100;

      final roundedEurStrValue = eur100.toStringAsFixed(2);
      final roundedUsdStrValue = usd100.toStringAsFixed(2);
      final roundedRubStrValue = rub1000.toStringAsFixed(2);

      convertedEurStrValue = RxString(roundedEurStrValue);
      convertedUsdStrValue = RxString(roundedUsdStrValue);
      convertedRubStrValue = RxString(roundedRubStrValue);
    } finally {
      isCurrencyLoading(false);
    }
  }
}