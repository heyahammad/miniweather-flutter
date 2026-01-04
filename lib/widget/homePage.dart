import 'package:flutter/material.dart';
import 'package:miniweather/model/weather.dart';
import 'package:lottie/lottie.dart';
import 'package:miniweather/service/weatherLoad.dart';
import 'package:google_fonts/google_fonts.dart';

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

  Widget showAnima(String condition) {
    if (condition == 'Rain') {
      return Lottie.asset(
        'assets/animation/rain.json',
        width: 200,
        height: 200,
      );
    } else if (condition == 'Clear') {
      return Lottie.asset(
        'assets/animation/clear.json',
        width: 200,
        height: 200,
      );
    } else if (condition == 'Clouds') {
      return Lottie.asset(
        'assets/animation/cloudy.json',
        width: 200,
        height: 200,
      );
    } else if (condition == 'Snow') {
      return Lottie.asset(
        'assets/animation/snow.json',
        width: 200,
        height: 200,
      );
    } else if (condition == 'Drizzle') {
      return Lottie.asset(
        'assets/animation/drizzle.json',
        width: 200,
        height: 200,
      );
    } else if (condition == 'Thunderstorm') {
      return Lottie.asset(
        'assets/animation/storm.json',
        width: 200,
        height: 200,
      );
    } else if (condition == 'Mist' ||
        condition == 'Fog' ||
        condition == 'Haze') {
      return Lottie.asset(
        'assets/animation/mist.json',
        width: 200,
        height: 200,
      );
    } else {
      return Lottie.asset(
        'assets/animation/windy.json',
        width: 200,
        height: 200,
      );
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
      appBar: AppBar(
        title: Text(
          'Minima Weather',
          style: GoogleFonts.styleScript(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Text(
                  _weather?.cityName.toUpperCase() ?? 'Loading...',
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                _weather != null
                    ? showAnima(_weather!.mainCondition)
                    : CircularProgressIndicator(),
                SizedBox(height: 10),
                Text(
                  _weather != null ? '${_weather!.temperature} °C' : '',
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // SizedBox(height: 20),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Lottie.asset(
              'assets/animation/customcat.json',
              width: 150,
              height: 150,
            ),
          ),
        ],
      ),
    );
  }
}
