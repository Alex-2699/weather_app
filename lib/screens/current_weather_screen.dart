import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_app/models/models.dart';
import 'package:weather_app/providers/providers.dart';
import 'package:weather_app/utils/utils.dart';
import 'package:weather_app/widgets/widgets.dart';

class CurrentWeatherScreen extends ConsumerWidget {

  const CurrentWeatherScreen({super.key});

  Widget _buildDetailScreen(WidgetRef ref, WeatherResponse weatherData) {
    final locationPropertiesProv = ref.watch(locationPropertiesProvider);

    return SafeArea(
      bottom: false,
      child: RefreshIndicator(
        onRefresh: () async => ref.refresh(weatherProvider.future),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              HeaderWeatherStatistics(
                thermalSensation: weatherData.hourly.currentThermalSensation,
                precipitationPercent: weatherData.hourly.currentPrecipitation,
                windSpeedPercent: weatherData.currentWeather.windSpeed,
              ),
              CurrentWeather(
                temp: weatherData.currentWeather.temperature,
                tempMax: weatherData.daily.tempMax[0],
                tempMin: weatherData.daily.tempMin[0],
              ),
              LocationWeather(
                location: locationPropertiesProv.placeName,
                weatherDescription: WeatherData.weatherInterpretationCodes[weatherData.currentWeather.weatherCode]!,
              ),
              const WeatherForecastList(isHourly: true),
              const WeatherForecastList(isHourly: false),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeatherProvider = ref.watch(weatherProvider);

    return Scaffold(
      body: Stack(
        children: [
          GradientDecoration(),
          Align(alignment: Alignment.bottomCenter, child: MountainBackground()),
          currentWeatherProvider.when(
            data: (data) => _buildDetailScreen(ref, data), 
            error: (error, stackTrace) => const ErrorScreen(),
            loading: () => CustomProgressIndicator.staggeredDotsWave(),
          ),
        ],
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: currentWeatherProvider.hasError ? null : FABMenu(),
    );
  }

}