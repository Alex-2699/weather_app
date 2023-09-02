import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:weather_app/models/models.dart';

class WeatherProvider extends ChangeNotifier {

  // final String _baseUrl = 'api.openweathermap.org';
  // final String _apiKey = '1008daf195347471e9b5ef2bb328b9d5';
  // final String _units = 'metric';
  // final String _language = 'es';

  final String _baseUrl = 'api.open-meteo.com';


  Future<WeatherResponse> getCurrentWeather(double lat, double long) async {
    final String jsonData = await _getJsonData('v1/forecast', {
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


  Future<String> _getJsonData(String endPoint, Map<String, String> params) async {
    final Uri url = Uri.https(_baseUrl, endPoint, {
      ...params,
    });
    
    try {
      final response = await http.get(url);

      if(response.statusCode != 200) {
        throw Exception("Error en la solicitud HTTP: ${response.reasonPhrase}");
      }
      
      return response.body;

    } catch(error) {
      return Future.error(error.toString());
    }
  }

}
