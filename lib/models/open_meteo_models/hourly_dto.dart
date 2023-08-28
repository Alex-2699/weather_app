
class HourlyDto {

  List<DateTime> time;
  List<double> temperature;
  List<int> precipitation;
  List<int> cloudiness;
  List<double> windSpeed;

  HourlyDto({
    required this.time,
    required this.temperature,
    required this.precipitation,
    required this.cloudiness,
    required this.windSpeed,
  });

  factory HourlyDto.fromJson(Map<String, dynamic> json) => HourlyDto(
    time: List<DateTime>.from(json["time"].map((x) => DateTime.parse(x))),
    temperature: List<double>.from(json["temperature_2m"].map((x) => x?.toDouble())),
    precipitation: List<int>.from(json["precipitation_probability"].map((x) => x)),
    cloudiness: List<int>.from(json["cloudcover"].map((x) => x)),
    windSpeed: List<double>.from(json["windspeed_10m"].map((x) => x?.toDouble())),
  );

  int currentHour = DateTime.now().hour;

  get currentcloudiness => cloudiness[currentHour];
  get currentwindSpeed => windSpeed[currentHour];
  get currentPrecipitation => precipitation[currentHour];

}

class HourlyUnits {

  String time;
  String temperatureM;
  String precipitationProbability;
  String cloudiness;
  String windSpeed;

  HourlyUnits({
    required this.time,
    required this.temperatureM,
    required this.precipitationProbability,
    required this.cloudiness,
    required this.windSpeed,
  });

  factory HourlyUnits.fromJson(Map<String, dynamic> json) => HourlyUnits(
    time: json["time"],
    temperatureM: json["temperature_2m"],
    precipitationProbability: json["precipitation_probability"],
    cloudiness: json["cloudcover"],
    windSpeed: json["windspeed_10m"],
  );

}