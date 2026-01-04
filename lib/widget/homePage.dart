import 'package:flutter/material.dart';
import 'package:miniweather/model/weather.dart';

import 'package:miniweather/service/weatherLoad.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final weatherService = WeatherLoad(api: '5202d7eff7f88f1607c7814368e2744b');

  Weather? _weather;
  String city = '';

  getWeather() async {
    city = await getCurrentCity();
    try {
      final weather = await weatherService.fetchWeather(city);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      throw Exception('Failed to load weather data: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minima Weather')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? 'Loading...'),
            Text(_weather != null ? '${_weather!.temperature} °C' : ''),
          ],
        ),
      ),
    );
  }
}
