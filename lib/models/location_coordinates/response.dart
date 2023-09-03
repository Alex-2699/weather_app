import 'package:weather_app/models/models.dart';

class Result {

  Geometry geometry;

  Result({required this.geometry});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    geometry: Geometry.fromJson(json["geometry"]),
  );

}