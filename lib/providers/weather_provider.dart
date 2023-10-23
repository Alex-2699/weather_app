import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_app/models/models.dart';
import 'package:weather_app/providers/providers.dart';
import 'package:weather_app/services/services.dart';

final coordinatesProvider = StateProvider<Location>((ref) {
  return Location(lat: 0.0, lng: 0.0);
});

final weatherProvider = FutureProvider.autoDispose<WeatherResponse>((ref) async {
  final coordinates = ref.watch(coordinatesProvider);
  final currentWeather = await WeatherService.getCurrentWeather(coordinates.lat, coordinates.lng);

  await ref.watch(weatherForecastProvider.notifier).updateWeatherData(currentWeather);
  ref.watch(weatherForecastProvider.notifier).updateSelectedDayIndex(0);
  ref.watch(weatherForecastProvider.notifier).updateScrolledToIndex(false);

  // ref.watch(appThemeProvider);

  return currentWeather;
});

