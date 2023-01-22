import 'package:flutter/material.dart';
import 'package:flutter_demo/models/geolocation_model.dart';
import 'package:flutter_demo/models/status.dart';
import 'package:flutter_demo/models/weather_model.dart';
import 'package:flutter_demo/ui/home/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GeoLocationModel(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //1. task one
    return MultiProvider( /* 1. task one */
      providers:  [
        ChangeNotifierProvider(
          create: (_) => WeatherModel()
        ),
      ],
      child: MaterialApp(
        title: 'Simple Weather',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const LocationLoader(),
      ),
    );
  }
}

class LocationLoader extends StatelessWidget {
  const LocationLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GeoLocationModel>(
      builder: (context, data, _child) {
        if (data.status == Status.busy) {
          return const IsFetching();
        }
        if (data.location == null) {
          return const LocationError();
        }
        return const HomePage(); 
        //1. task one
        // ChangeNotifierProvider(
        //   create: (_) => WeatherModel(),
        //   child: const HomePage(),
        // );
      },
    );
  }
}

class IsFetching extends StatelessWidget {
  const IsFetching({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}

class LocationError extends StatelessWidget {
  const LocationError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(
          child: Text('Cannot get location. Sad face'),
        ),
      ],
    );
  }
}
