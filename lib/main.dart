import 'package:flutter/material.dart';
import 'screens/converter_screen.dart';
import 'screens/currency_screen.dart';
import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppNavBar(),
    );
  }
}

class AppNavBar extends StatefulWidget {
  const AppNavBar({Key? key}) : super(key: key);

  @override
  _AppNavBarState createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> {
  int _selectedIndex = 0;
  List<Widget> bottomNavBarScreenList = [
    ConverterScreen(),
    CurrencyScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 25,
        selectedItemColor: Colors.white,
        backgroundColor: secondColor.withOpacity(0.5),
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.white38,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Converter'),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: 'Curency'),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: bottomNavBarScreenList[_selectedIndex],
    );
  }
}
