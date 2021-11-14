import 'package:currency_converter/controllers/currency_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:currency_converter/constants.dart';
import 'package:get/get.dart';
import 'package:currency_converter/widgets/prog_indicator.dart';

class CurrencyScreen extends StatefulWidget {
  CurrencyScreen({Key? key}) : super(key: key);

  final CurrencyController c = Get.put(CurrencyController());

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  late FixedExtentScrollController scrollController;
  List<String> currencySortedList = [];

  int index = 0;

  static const double? currencyTextSize = 22;

  @override
  void initState() {
    currencySortedList = sort(currencyList);
    index = currencySortedList.indexOf('TJS');
    scrollController = FixedExtentScrollController(
      initialItem: index,
    );
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  List<String> sort(List<String> inputList) {
    inputList.sort();
    return inputList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondColor,
        title: const Text('Курсы валют'),
      ),
      backgroundColor: mainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Базовая валюта: ',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Obx(() {
                        if (widget.c.isCurrencyLoading()) {
                          return const ProgIndicator();
                        }
                        return Text(
                          '${widget.c.baseCurrency}',
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 40),
                      const SizedBox(
                        height: 40,
                        width: 40,
                        child: Image(
                          image: AssetImage('assets/eur.png'),
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        '1 EUR = ',
                        style: TextStyle(
                          fontSize: currencyTextSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Obx(() {
                        if (widget.c.isCurrencyLoading()) {
                          return const ProgIndicator();
                        }
                        return Text(
                          '${widget.c.convertedEurStrValue} ${widget.c.baseCurrency}',
                          style: const TextStyle(
                            fontSize: currencyTextSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 40),
                      const SizedBox(
                        height: 40,
                        width: 40,
                        child: Image(
                          image: AssetImage('assets/usd.png'),
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        '1 USD = ',
                        style: TextStyle(
                          fontSize: currencyTextSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Obx(() {
                        if (widget.c.isCurrencyLoading()) {
                          return const ProgIndicator();
                        }
                        return Text(
                          '${widget.c.convertedUsdStrValue} ${widget.c.baseCurrency}',
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 40),
                      const SizedBox(
                        height: 40,
                        width: 40,
                        child: Image(
                          image: AssetImage('assets/rub.png'),
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        '1 RUB = ',
                        style: TextStyle(
                          fontSize: currencyTextSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Obx(() {
                        if (widget.c.isCurrencyLoading()) {
                          return const ProgIndicator();
                        }
                        return Text(
                          '${widget.c.convertedRubStrValue} ${widget.c.baseCurrency}',
                          style: const TextStyle(
                            fontSize: currencyTextSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        scrollController.dispose();
                        scrollController =
                            FixedExtentScrollController(initialItem: index);
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) => CupertinoActionSheet(
                            title: const Text('Выберите базовую валюту'),
                            actions: [buildPicker()],
                            cancelButton: CupertinoActionSheetAction(
                              child: const Text('Отмена'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        );
                      },
                      child: const Text("Изменить базовую валюту"),
                      style: ElevatedButton.styleFrom(
                        primary: secondColor,
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPicker() {
    return StatefulBuilder(
      builder: (context, setState) => SizedBox(
        height: 250,
        child: CupertinoPicker(
          scrollController: scrollController,
          onSelectedItemChanged: (index) {
            final selectedCur = currencySortedList[index];
            widget.c.baseCurrency = RxString(currencySortedList[index]);
            widget.c.fetchCurrency(currencySortedList[index]);
            print('Selected Currency: $selectedCur');
          },
          itemExtent: 64,
          selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
            background: CupertinoColors.activeBlue.withOpacity(0.2),
          ),
          children: List.generate(currencySortedList.length, (index) {
            final isSelected = this.index == index;
            final currency = currencySortedList[index];
            // final color =
            // isSelected ? CupertinoColors.activeBlue : CupertinoColors.black;

            return Center(
              child: Text(
                currency,
                style: const TextStyle(fontSize: 30),
              ),
            );
          }),
        ),
      ),
    );
  }
}
