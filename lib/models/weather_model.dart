import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/models/status.dart';
import 'package:geolocator/geolocator.dart';

const API_KEY = 'd8eb7ae1a35d42c1cc5780438b0975a3';

class WeatherModel extends ChangeNotifier {
  WeatherModel();

  final _client = Dio();
  Status status = Status.idle;

  WeatherData? localWeather;
  List<WeatherData> localWeatherForecast = const [];

  Future<void> getLocalWeather(Position location) async {
    status = Status.busy;
    notifyListeners();

    final response = await _client.get<Map<String, dynamic>>(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$API_KEY&units=metric');

    localWeather = WeatherData.fromDynamic(response.data);

    status = Status.idle;
    notifyListeners();
  }

  Future<void> getForecast(Position location) async {
    status = Status.busy;
    notifyListeners();

    final response = await _client.get<Map<String, dynamic>>(
        'https://api.openweathermap.org/data/2.5/forecast?lat=${location.latitude}&lon=${location.longitude}&appid=$API_KEY&units=metric');

    final days = _hourlyForecastToDays(response.data?['list']);
    localWeatherForecast = (days).map((item) {
      return ListWeatherData.fromDynamic(Map<String, dynamic>.from({
        'main': item['main'],
        'weather': item['weather'],
        'name': response.data?['city']['name'],
      }));
    }).toList();
    
    print(response);
    status = Status.idle;
    notifyListeners();
  }

  static String iconUrl(String code) => 'http://openweathermap.org/img/wn/$code@2x.png';
}

/// Converts items based on 3 hour forecast to single days.
List<dynamic> _hourlyForecastToDays(List<dynamic> data) {
  // TODO: Fold the hourly entries into days
  return data;
}

class WeatherData {
  WeatherData({
    this.city,
    this.temp,
    this.icon,
    this.description,
  });

  String? city;
  double? temp;
  String? icon;
  String? description;

  static WeatherData fromDynamic(Map<String, dynamic>? data) => WeatherData(
    description: data?['weather']?.first?['description'], // few clouds
    icon: data?['weather']?.first?['icon'], // 02n
    temp: data?['main']?['temp'], // 17.232
    city: data?['name'], // Sydney
  );
}

class ListWeatherData {
  static WeatherData fromDynamic(Map<String, dynamic>? data) => WeatherData(
    description: data?['weather']?.first?['description'], // few clouds
    icon: data?['weather']?.first?['icon'], // 02n
    temp: data?['main']?['temp'], // 17.232
    city: data?['name'], // Sydney
  );
}