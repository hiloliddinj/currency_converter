import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:currency_converter/constants.dart';
import 'package:get/get.dart';
import 'package:currency_converter/controllers/converter_controller.dart';
import 'package:currency_converter/widgets/prog_indicator.dart';

class ConverterScreen extends StatefulWidget {
  ConverterScreen({Key? key}) : super(key: key);

  final ConverterController c = Get.put(ConverterController());

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  TextEditingController controller = TextEditingController();

  String targetCurrency = "";

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
              const Expanded(
                flex: 1,
                child: SizedBox(
                  width: 200,
                  child: Text(
                    "Currency Converter",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Column(
                      children: [
                        const Center(
                          child: Text(
                            "Converted Value:",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Obx(() {
                          if (widget.c.isCurrencyLoading()) {
                            return const ProgIndicator();
                          } else {
                            return Center(
                              child: Text(
                                widget.c.convertedStrValue.value,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }
                        }),
                      ],
                    ),
                  )),
              Expanded(
                flex: 2,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        autocorrect: false,
                        controller: controller,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Example Format: 15 usd in rub",
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          labelStyle: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: secondColor),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: _handleConvertPressed,
                        child: const Text("Convert"),
                        style: ElevatedButton.styleFrom(
                          primary: secondColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleConvertPressed() {
    if (controller.text.isNotEmpty) {
      // Format: "15 usd in rub"
      List x = controller.text.split(" ");
      if (x.length == 4) {
        try {
          var doubleValue = double.parse(x[0]);
          //print(doubleValue);
          if (x[2].length == 2 && x[2].toUpperCase() == "IN") {
            if (x[1].length == 3) {
              if (x[3].length == 3) {
                String cur1 = x[1].toUpperCase();
                String cur2 = x[3].toUpperCase();
                bool cur1Found = false;
                bool cur2Found = false;
                for (var u in currencyList) {
                  if (u == cur1 && !cur1Found) {cur1Found = true;}
                  if (u == cur2 && !cur2Found) {cur2Found = true;}
                  if (cur1Found && cur2Found) {break;}
                }
                if (cur1Found) {
                  if(cur2Found) {
                    widget.c.fetchCurrency(doubleValue, cur1, cur2);
                  } else {
                    _showMyDialog("2nd Currency not found!");
                  }
                } else {
                  _showMyDialog("1st Currency not found!");
                }
              } else {
                _showMyDialog("2nd Currency must be 3 letter");
              }
            } else {
              _showMyDialog("1st Currency must be 3 letter");
            }
          } else {
            _showMyDialog("You need to write 'in' between currencies");
          }
        } on Exception catch (_) {
          _showMyDialog("Wrong Number Format!");
        }
      } else {
        _showMyDialog("Wrong Format!");
      }
    } else {
      _showMyDialog("Field can not be empty!");
    }
  }

  Future<void> _showMyDialog(String message) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Example Format: "15 usd in rub"'),
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}