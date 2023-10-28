import 'package:worldtime/worldtime.dart';

import 'package:weather_app/models/models.dart';
import 'package:weather_app/utils/utils.dart';

class WeatherService {

  static Future<WeatherResponse> getCurrentWeather(double lat, double long) async {

    final DateTime locationDate = await Worldtime().timeByLocation(latitude: lat, longitude: long);

    final startDate = DateAndTimeFormat.formatDateTime('$locationDate', 'yyyy-MM-dd');
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

    return WeatherResponse.fromJson(jsonData);
  }

}