
import 'package:flutter/material.dart';
import 'package:weather_app/models/models.dart';

class WeatherForecastProvider extends ChangeNotifier {

  late HourlyDto _hourlyWeather;
  late DailyDto _dailyWeather;
  late String _isoSunriseDate;
  late String _isoSunsetDate;
  late int _currentHour;

  int _selectedDayIndex = 0;
  bool _hasScrolledToIndex = false;

  Future<void> updateWeatherData(WeatherResponse weatherData) async {
    _hourlyWeather = weatherData.hourly;
    _dailyWeather = weatherData.daily;
    _isoSunriseDate = (weatherData.daily.sunrise.isNotEmpty
        ? weatherData.daily.sunrise[0]
        : null)!;
    _isoSunsetDate = (weatherData.daily.sunset.isNotEmpty
        ? weatherData.daily.sunset[0]
        : null)!;
    _currentHour = DateTime.parse(weatherData.currentWeather.time).hour -1;
  }

  Future<void> updateSelectedDayIndex(int selectedDayIndex) async {
    _selectedDayIndex = selectedDayIndex;
    notifyListeners();
  }

  Future<void> updateScrolledToIndex(bool hasScrolledToIndex) async {
    _hasScrolledToIndex = hasScrolledToIndex;
  }

  HourlyDto get hourlyWeather => _hourlyWeather;

  DailyDto get dailyWeather => _dailyWeather;

  String get isoSunriseDate => _isoSunriseDate;

  String get isoSunsetDate => _isoSunsetDate;

  int get currentHour => _currentHour;

  int get selectedDayIndex => _selectedDayIndex;

  bool get hasScrolledToIndex => _hasScrolledToIndex;

}