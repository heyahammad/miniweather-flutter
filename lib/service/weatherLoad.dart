import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:miniweather/model/weather.dart';
import 'package:http/http.dart' as http;

class WeatherLoad {
  final baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  String api;

  WeatherLoad({required this.api});

  Future<Weather> fetchWeather(String city) async {
    final url = '$baseUrl?q=$city&appid=$api&units=metric';
    //now fetching logic here
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}

Future<String> getCurrentCity() async {
  LocationPermission permission = await Geolocator.checkPermission();

  //get permission from user
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  //get current position

  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  //get city name from position

  List<Placemark> placemark = await placemarkFromCoordinates(
    position.latitude,
    position.longitude,
  );

  String currentCity = placemark[0].locality ?? '';

  return currentCity;
}
