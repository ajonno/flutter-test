import 'package:flutter/material.dart';
import 'package:flutter_demo/models/geolocation_model.dart';
import 'package:flutter_demo/models/status.dart';
import 'package:flutter_demo/models/weather_model.dart';
import 'package:provider/provider.dart';

import 'components/daily_forecast.dart';

class ForecastPage extends StatelessWidget {
  const ForecastPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Forecast'),
      ),
      body: Center(
        child: Consumer<WeatherModel>(
          builder: (context, data, _child) {
            if (data.status == Status.busy) {
              return const Center(child: CircularProgressIndicator());
            }

            if (data.localWeatherForecast.isNotEmpty) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: data.localWeatherForecast
                    .map((weather) => DailyForecast(weather: weather))
                    .toList(),
              );
            }

            // No data yet
            return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    context.read<WeatherModel>().getForecast(
                          context.read<GeoLocationModel>().location!,
                        );
                  },
                  child: const Text('Load forecast'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}