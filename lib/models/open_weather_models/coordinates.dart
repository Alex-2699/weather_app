class Coordinates {

  double lat;
  double lon;

  Coordinates({
    required this.lat,
    required this.lon,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
    lat: json["lat"]?.toDouble(),
    lon: json["lon"]?.toDouble(),
  );

}