import 'dart:convert';

import 'package:weather_app/models/models.dart';

class CurrentWeatherResponse {

  Coordinates coordinates;
  List<WeatherCondition> weatherCondition;
  String internalParameterBase;
  Statistics statistics;
  int visibility;
  WindCondition wind;
  Clouds clouds;
  int dt;
  SunriseSunsetInfo sunriseSunsetInfo;
  int timezone;
  int id;
  String name;
  int cod;

  CurrentWeatherResponse({
    required this.coordinates,
    required this.weatherCondition,
    required this.internalParameterBase,
    required this.statistics,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sunriseSunsetInfo,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory CurrentWeatherResponse.fromJson(String str) => CurrentWeatherResponse.fromMap(json.decode(str));

  factory CurrentWeatherResponse.fromMap(Map<String, dynamic> json) => CurrentWeatherResponse(
    coordinates: Coordinates.fromJson(json["coord"]),
    weatherCondition: List<WeatherCondition>.from(json["weather"].map((x) => WeatherCondition.fromJson(x))),
    internalParameterBase: json["base"],
    statistics: Statistics.fromJson(json["main"]),
    visibility: json["visibility"],
    wind: WindCondition.fromJson(json["wind"]),
    clouds: Clouds.fromJson(json["clouds"]),
    dt: json["dt"],
    sunriseSunsetInfo: SunriseSunsetInfo.fromJson(json["sys"]),
    timezone: json["timezone"],
    id: json["id"],
    name: json["name"],
    cod: json["cod"],
  );

}