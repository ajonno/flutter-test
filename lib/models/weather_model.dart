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

  //task 3: The forecast response data is a list of hourly results
  //spanning 6 days
  //the optional task is to display 1 x result per day (over 6 days)
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

List<dynamic> _hourlyForecastToDays(List<dynamic> data) {
  //Fold the hourly entries into days
  // return data;
  Map<int, List<Map<String, dynamic>>> groups = data.fold({}, (prev, current) {
    int date = current?["dt"];

    var dayofweek = _getDayOfWeek(date);

    if (prev.containsKey(dayofweek) == false) {
      prev[dayofweek] = [current];
    } else {
      prev[dayofweek]?.add(current);
    }
    return prev;
  });

  //now calculate the AVG temp for each day since every 3 hrs temps are different
  //and store each day's avg temp in a new list
  List<dynamic> foldedList = [];
  groups.forEach((key, value) {
    double sum = 0;
    for (var element in value) {
      sum += element['main']['temp'];
    }
    double avg = sum / value.length;
    value[0]['main']['temp'] = avg;
    foldedList.add(value[0]);
  });

  return foldedList;
}

int _getDayOfWeek(int epochValue) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(epochValue * 1000);
  int dayOfWeek = date.weekday;
  return dayOfWeek;
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
  int? dayOfWeek;

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
