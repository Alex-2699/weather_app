import 'dart:convert';

import 'package:weather_app/models/models.dart';

class WeatherResponse {

  double latitude;
  double longitude;
  double generationTimeMs;
  int utcOffSetSeconds;
  String timezone;
  String timezoneAbbreviation;
  double elevation;
  CurrentWeatherDto currentWeather;
  HourlyUnits hourlyUnits;
  HourlyDto hourly;
  DailyUnits dailyUnits;
  DailyDto daily;

  WeatherResponse({
    required this.latitude,
    required this.longitude,
    required this.generationTimeMs,
    required this.utcOffSetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.currentWeather,
    required this.hourlyUnits,
    required this.hourly,
    required this.dailyUnits,
    required this.daily,
  });

  factory WeatherResponse.fromJson(String str) => WeatherResponse.fromMap(json.decode(str));

  factory WeatherResponse.fromMap(Map<String, dynamic> json) => WeatherResponse(
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    generationTimeMs: json["generationtime_ms"]?.toDouble(),
    utcOffSetSeconds: json["utc_offset_seconds"],
    timezone: json["timezone"],
    timezoneAbbreviation: json["timezone_abbreviation"],
    elevation: json["elevation"],
    currentWeather: CurrentWeatherDto.fromJson(json["current_weather"]),
    hourlyUnits: HourlyUnits.fromJson(json["hourly_units"]),
    hourly: HourlyDto.fromJson(json["hourly"]),
    dailyUnits: DailyUnits.fromJson(json["daily_units"]),
    daily: DailyDto.fromJson(json["daily"]),
  );

}
