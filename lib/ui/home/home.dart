import 'package:flutter/material.dart';
import 'package:flutter_demo/models/geolocation_model.dart';
import 'package:flutter_demo/models/status.dart';
import 'package:flutter_demo/models/weather_model.dart';
import 'package:flutter_demo/ui/common/weather_icon.dart';
import 'package:flutter_demo/ui/forecast/forecast.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Weather'),
      ),
      body: Center(
        child: Consumer<WeatherModel>(
          builder: (context, data, _child) {
            if (data.status == Status.busy) {
              return const Center(child: CircularProgressIndicator());
            }

            //we have some data now
            if (data.localWeather?.city != null) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      WeatherIcon(
                        icon: data.localWeather!.icon!,
                        size: 100,
                      ),
                      /// Temperature
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          '${data.localWeather!.temp!.round().toString()}ºC',
                          style: const TextStyle(fontSize: 40),
                        ),
                      ),
                      /// Weather description
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          data.localWeather!.description!,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      /// City name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.map_sharp, size: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              data.localWeather!.city!,
                              style: const TextStyle(fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ForecastPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'See Forecast 👀',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              );
            }

            // No data yet
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    context.read<WeatherModel>().getLocalWeather(
                          context.read<GeoLocationModel>().location!,
                        );
                  },
                  child: const Text(
                    'Load today\'s weather',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ForecastPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'See forecast 👀',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
