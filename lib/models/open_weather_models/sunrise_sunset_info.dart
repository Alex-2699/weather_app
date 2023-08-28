class SunriseSunsetInfo {

  String country;
  int sunrise;
  int sunset;

  SunriseSunsetInfo({
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory SunriseSunsetInfo.fromJson(Map<String, dynamic> json) => SunriseSunsetInfo(
    country: json["country"],
    sunrise: json["sunrise"],
    sunset: json["sunset"],
  );

}