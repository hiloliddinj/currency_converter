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

  @override
  void initState() {
    currencySortedList = sort(currencyList);
    index = currencySortedList.indexOf('RUB');
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
      ),
      backgroundColor: mainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 200,
                child: Text(
                  "Currency Rates",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 50),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() {
                    if (widget.c.isCurrencyLoading()) {
                      return const ProgIndicator();
                    }
                    return Text(
                      'Base Currency: ${widget.c.baseCurrency}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }),
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
                      Obx(() {
                        if (widget.c.isCurrencyLoading()) {
                          return const ProgIndicator();
                        }
                        return Text(
                          '1 USD = ${widget.c.convertedUsdStrValue} ${widget.c.baseCurrency}',
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
                          image: AssetImage('assets/usd.png'),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Obx(() {
                        if (widget.c.isCurrencyLoading()) {
                          return const ProgIndicator();
                        }
                        return Text(
                          '1 UER = ${widget.c.convertedEurStrValue} ${widget.c.baseCurrency}',
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
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        scrollController.dispose();
                        scrollController =
                            FixedExtentScrollController(initialItem: index);
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) => CupertinoActionSheet(
                            title: const Text('Select Base Currency:'),
                            actions: [buildPicker()],
                            cancelButton: CupertinoActionSheetAction(
                              child: const Text('Cancel'),
                              onPressed: () => Navigator.pop(context),
                            ),

                          ),
                        );
                      },
                      child: const Text("Change Base Currency"),
                      style: ElevatedButton.styleFrom(
                        primary: secondColor,
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
            final color =
            isSelected ? CupertinoColors.activeBlue : CupertinoColors.black;

            return Center(
              child: Text(
                currency,
                style: TextStyle(fontSize: 32, color: color),
              ),
            );
          }),
        ),
      ),
    );
  }
}
