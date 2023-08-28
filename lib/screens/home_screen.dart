import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/models.dart';

import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/resources/weather_data.dart';
import 'package:weather_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _buildScreen(WeatherResponse weather) {
    return Stack(
      children: [
        const GradientDecoration(),
        const Align(alignment: Alignment.bottomCenter, child: MountainBackground()),
        SafeArea(
          child: Column(
            children: [
              HeaderWeatherStatistics(
                cloudinessPercent: weather.hourly.currentcloudiness,
                humidityPercent: weather.hourly.currentPrecipitation,
                windSpeedPercent: weather.hourly.currentwindSpeed,
              ),
              CurrentWeather(
                temp: weather.currentWeather.temperature.toInt(),
                tempMax: weather.daily.tempMax.toInt(),
                tempMin: weather.daily.tempMin.toInt(),
              ),
              LocationWeather(
                location: 'san juan bautista tuxtepec',
                country: 'mx',
                weatherDescription: WeatherData.weatherInterpretationCodes[weather.currentWeather.weatherCode]!,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      body: FutureBuilder(
        future: weatherProvider.getCurrentWeather(18.1074, -96.1457),
        builder: (_, AsyncSnapshot<WeatherResponse> snapshot) {
          if(!snapshot.hasData) return const Center(child: CupertinoActivityIndicator());
          
          return _buildScreen(snapshot.data!);
        }
      ),
    );
  }

}
