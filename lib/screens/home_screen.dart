import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/models.dart';
import 'package:weather_app/providers/providers.dart';
import 'package:weather_app/theme/app_theme.dart';

import 'package:weather_app/utils/provider_enums.dart';
import 'package:weather_app/utils/weather_data.dart';
import 'package:weather_app/widgets/resources/resources.dart';
import 'package:weather_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {

  final String locationName;
  final double latitude;
  final double longitude;

  const HomeScreen({
    super.key,
    required this.locationName,
    required this.latitude,
    required this.longitude,
  });

  Widget _buildDetailScreen(BuildContext context, WeatherResponse weather) {
    return SafeArea(
      bottom: false,
      child: RefreshIndicator(
        onRefresh: () async => _fetchWeatherData(context),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              HeaderWeatherStatistics(
                thermalSensation: weather.hourly.currentThermalSensation,
                precipitationPercent: weather.hourly.currentPrecipitation,
                windSpeedPercent: weather.currentWeather.windSpeed,
              ),
              CurrentWeather(
                temp: weather.currentWeather.temperature,
                tempMax: weather.daily.tempMax[0],
                tempMin: weather.daily.tempMin[0],
              ),
              LocationWeather(
                location: locationName,
                weatherDescription: WeatherData.weatherInterpretationCodes[weather.currentWeather.weatherCode]!,
              ),
              const WeatherForecast(isHourly: true),
              const WeatherForecast(isHourly: false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WeatherProvider weatherProvider) {
    switch (weatherProvider.fetchState) {
      case FetchState.loading:
        return CustomProgressIndicator.staggeredDotsWave();

      case FetchState.error:
        return Text(weatherProvider.errorMessage);

      case FetchState.completed:
        _updateWeatherForecastProvider(context, weatherProvider.weatherData);
        return _buildDetailScreen(context, weatherProvider.weatherData);

      default:
        return Container();
    }
  }

  Future<void> _updateWeatherForecastProvider(BuildContext context, WeatherResponse weatherData) async {
    final forecastProvider = Provider.of<WeatherForecastProvider>(context, listen: false);
    final darkModeProvider = Provider.of<AppTheme>(context, listen: false);
    
    await forecastProvider.updateWeatherData(weatherData);
    await forecastProvider.updateSelectedDayIndex(0);
    await forecastProvider.updateScrolledToIndex(false);

    await darkModeProvider.updateDarkModeValue(weatherData.currentWeather.isDay != 1);
  }

  Future<void> _fetchWeatherData(BuildContext context) async {
    final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    await weatherProvider.getCurrentWeather(latitude, longitude);
  }

  FutureProvider<void> _futureWeatherProvider(BuildContext context) {
    return FutureProvider.value(
      initialData: null,
      value: _fetchWeatherData(context),
      child: Consumer<WeatherProvider>(builder: (_, weatherProvider, __) {
        return _buildContent(context, weatherProvider);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const GradientDecoration(),
          const Align(alignment: Alignment.bottomCenter, child: MountainBackground()),
          _futureWeatherProvider(context),
        ],
      ),
    );
  }

}
