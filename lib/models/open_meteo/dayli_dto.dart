class DailyDto {

  List<String> time;
  List<int> tempMax;
  List<int> tempMin;
  List<int> weathercode;
  List<String> sunrise;
  List<String> sunset;

  DailyDto({
    required this.time,
    required this.tempMax,
    required this.tempMin,
    required this.weathercode,
    required this.sunrise,
    required this.sunset,
  });

  factory DailyDto.fromJson(Map<String, dynamic> json) => DailyDto(
    time: List<String>.from(json["time"].map((x) => x)),
    tempMax: List<int>.from(json["temperature_2m_max"].map((x) => x?.toInt())),
    tempMin: List<int>.from(json["temperature_2m_min"].map((x) => x?.toInt())),
    weathercode: List<int>.from(json["weathercode"].map((x) => x?.toInt())),
    sunrise: List<String>.from(json["sunrise"].map((x) => x)),
    sunset: List<String>.from(json["sunset"].map((x) => x)),
  );

}

class DailyUnits {

  String time;
  String tempMax;
  String tempMin;

  DailyUnits({
    required this.time,
    required this.tempMax,
    required this.tempMin,
  });

  factory DailyUnits.fromJson(Map<String, dynamic> json) => DailyUnits(
    time: json["time"],
    tempMax: json["temperature_2m_max"],
    tempMin: json["temperature_2m_min"],
  );

}