import 'package:flutter/material.dart';
import 'package:flutter_demo/models/weather_model.dart';

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({
    Key? key,
    required this.icon,
    this.size = 100,
  }) : super(key: key);
  final String icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.network(
        WeatherModel.iconUrl(icon),
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
