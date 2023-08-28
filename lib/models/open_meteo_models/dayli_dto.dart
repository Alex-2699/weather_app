class DailyDto {

  DateTime time;
  double tempMax;
  double tempMin;
  String sunrise;
  String sunset;

  DailyDto({
    required this.time,
    required this.tempMax,
    required this.tempMin,
    required this.sunrise,
    required this.sunset,
  });

  factory DailyDto.fromJson(Map<String, dynamic> json) => DailyDto(
    time: DateTime.parse(json["time"][0]),
    tempMax: json["temperature_2m_max"][0],
    tempMin: json["temperature_2m_min"][0],
    sunrise: json["sunrise"][0],
    sunset: json["sunset"][0],
  );

}

class DailyUnits {

  String time;
  String tempMax;
  String tempMin;
  String sunrise;
  String sunset;

  DailyUnits({
    required this.time,
    required this.tempMax,
    required this.tempMin,
    required this.sunrise,
    required this.sunset,
  });

  factory DailyUnits.fromJson(Map<String, dynamic> json) => DailyUnits(
    time: json["time"],
    tempMax: json["temperature_2m_max"],
    tempMin: json["temperature_2m_min"],
    sunrise: json["sunrise"],
    sunset: json["sunset"],
  );

}