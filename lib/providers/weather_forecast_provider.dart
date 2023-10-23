import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_app/models/models.dart';


final weatherForecastProvider = StateNotifierProvider<WeatherForecastNotifier, WeatherForecast>((ref) {
  return WeatherForecastNotifier();
});

class WeatherForecastNotifier extends StateNotifier<WeatherForecast> {
  WeatherForecastNotifier() : super(WeatherForecast());

  Future<void> updateWeatherData(WeatherResponse weatherData) async {
    state = state.copyWith(
      hourlyWeather: weatherData.hourly,
      dailyWeather: weatherData.daily,
      isoSunriseDate: weatherData.daily.sunrise.isNotEmpty ? weatherData.daily.sunrise[0] : null,
      isoSunsetDate: weatherData.daily.sunset.isNotEmpty ? weatherData.daily.sunset[0] : null,
      currentHour: DateTime.parse(weatherData.currentWeather.time).hour - 1,
    );
  }

  void updateSelectedDayIndex(int selectedDayIndex) {
    state = state.copyWith(selectedDayIndex: selectedDayIndex);
  }

  void updateScrolledToIndex(bool hasScrolledToIndex) {
    state = state.copyWith(hasScrolledToIndex: hasScrolledToIndex);
  }
  
}

class WeatherForecast {

  final HourlyDto? hourlyWeather;
  final DailyDto? dailyWeather;
  final String? isoSunriseDate;
  final String? isoSunsetDate;
  final int? currentHour;
  final int selectedDayIndex;
  final bool hasScrolledToIndex;
  
  WeatherForecast({
    this.hourlyWeather,
    this.dailyWeather,
    this.isoSunriseDate,
    this.isoSunsetDate,
    this.currentHour,
    this.selectedDayIndex = 0,
    this.hasScrolledToIndex = false,
  });

  WeatherForecast copyWith({
    HourlyDto? hourlyWeather,
    DailyDto? dailyWeather,
    String? isoSunriseDate,
    String? isoSunsetDate,
    int? currentHour,
    int? selectedDayIndex,
    bool? hasScrolledToIndex,
  }) {
    return WeatherForecast(
      hourlyWeather: hourlyWeather ?? this.hourlyWeather,
      dailyWeather: dailyWeather ?? this.dailyWeather,
      isoSunriseDate: isoSunriseDate ?? this.isoSunriseDate,
      isoSunsetDate: isoSunsetDate ?? this.isoSunsetDate,
      currentHour: currentHour ?? this.currentHour,
      selectedDayIndex: selectedDayIndex ?? this.selectedDayIndex,
      hasScrolledToIndex: hasScrolledToIndex ?? this.hasScrolledToIndex,
    );
  }

}
