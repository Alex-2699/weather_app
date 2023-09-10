class CurrentWeatherDto {

  int temperature;
  int windSpeed;
  int windDirection;
  int weatherCode;
  int isDay;
  String time;

  CurrentWeatherDto({
    required this.temperature,
    required this.windSpeed,
    required this.windDirection,
    required this.weatherCode,
    required this.isDay,
    required this.time,
  });

  factory CurrentWeatherDto.fromJson(Map<String, dynamic> json) => CurrentWeatherDto(
    temperature: json["temperature"]?.toInt(),
    windSpeed: json["windspeed"]?.toInt(),
    windDirection: json["winddirection"],
    weatherCode: json["weathercode"],
    isDay: json["is_day"],
    time: json["time"],
  );

}