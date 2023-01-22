import 'package:flutter/material.dart';
import 'package:flutter_demo/models/weather_model.dart';

class DailyForecast extends StatelessWidget {
  const DailyForecast({
    Key? key,
    required this.weather,
  }) : super(key: key);
  final WeatherData weather;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${weather.temp!.toStringAsFixed(2)}ºC',
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
