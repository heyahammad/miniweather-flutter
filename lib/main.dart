import 'package:flutter/material.dart';
import 'package:miniweather/widget/homePage.dart';

void main() {
  runApp(const MiniWeatherMain());
}

class MiniWeatherMain extends StatelessWidget {
  const MiniWeatherMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Weather',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}
