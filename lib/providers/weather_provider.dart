import 'package:flutter/material.dart';

import 'package:weather_app/models/models.dart';
import 'package:weather_app/utils/utils.dart';

class WeatherProvider extends ChangeNotifier {

  Future<WeatherResponse> getCurrentWeather(double lat, double long) async {
    final String jsonData = await ApiService().getJsonData(Environment.openMeteoUrl, 'v1/forecast', {
      'latitude': lat.toString(),
      'longitude': long.toString(),
      'timezone': 'auto',
      'forecast_days': '1',
      'current_weather': 'true',
      'daily': 'temperature_2m_max,temperature_2m_min,sunrise,sunset',
      'hourly': 'temperature_2m,precipitation_probability,cloudcover,windspeed_10m'
    });

    return WeatherResponse.fromJson(jsonData);
  }

}
