import 'package:weather_app/models/models.dart';

class Geometry {
  
  Location location;
  // Viewport viewport;

  Geometry({
    required this.location,
    // required this.viewport,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    location: Location.fromJson(json["location"]),
    // viewport: Viewport.fromJson(json["viewport"]),
  );

}