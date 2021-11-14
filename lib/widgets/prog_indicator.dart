import 'package:flutter/material.dart';
import 'package:currency_converter/constants.dart';

class ProgIndicator extends StatelessWidget {
  const ProgIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: secondColor),
    );
  }
}
