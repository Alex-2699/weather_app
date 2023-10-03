import 'package:flutter/material.dart';

import 'package:weather_app/models/models.dart';
import 'package:weather_app/utils/provider_enums.dart';
import 'package:weather_app/utils/utils.dart';

class WeatherProvider extends ChangeNotifier {

  FetchState _fetchState = FetchState.loading;
  String _errorMessage = '';

  late WeatherResponse weatherData;

  Future<void> getCurrentWeather(double lat, double long) async {
    _fetchState = FetchState.loading;

    try {
      final startDate = await DateAndTimeFormat.getCurrentDate();
      final endDate = DateAndTimeFormat.addDaysToDate(startDate, 6);

      final String jsonData = await ApiService.getJsonData(Environment.openMeteoUrl, 'v1/forecast', {
        'latitude': lat.toString(),
        'longitude': long.toString(),
        'timezone': 'auto',
        'start_date': startDate,
        'end_date': endDate,
        'current_weather': 'true',
        'hourly': 'temperature_2m,apparent_temperature,precipitation_probability,weathercode,windspeed_10m',
        'daily': 'weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset',
      });

      weatherData = WeatherResponse.fromJson(jsonData);
      _fetchState = FetchState.completed;

    } catch (error) {
      _fetchState = FetchState.error;
      _errorMessage = error.toString();
    }

    notifyListeners();
  }

  FetchState get fetchState => _fetchState;
  String get errorMessage => _errorMessage;

}
