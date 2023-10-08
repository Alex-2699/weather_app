
class HourlyDto {

  List<String> time;
  List<int> temperature;
  List<int> apparentTemperature;
  List<int> precipitation;
  List<int> weathercode;
  List<double> windSpeed;

  HourlyDto({
    required this.time,
    required this.temperature,
    required this.apparentTemperature,
    required this.precipitation,
    required this.weathercode,
    required this.windSpeed,
  });

  factory HourlyDto.fromJson(Map<String, dynamic> json) => HourlyDto(
    time: List<String>.from(json["time"].map((x) => x)).toList(),
    temperature: List<int>.from(json["temperature_2m"].map((x) => x.toInt())),
    apparentTemperature: List<int>.from(json["apparent_temperature"].map((x) => x.toInt())),
    precipitation: List<int>.from(json["precipitation_probability"].map((x) => x)),
    weathercode: List<int>.from(json["weathercode"].map((x) => x)),
    windSpeed: List<double>.from(json["windspeed_10m"].map((x) => x?.toDouble())),
  );

  int currentHour = DateTime.now().hour;

  get currentWindSpeed => windSpeed[currentHour];
  get currentPrecipitation => precipitation[currentHour];
  get currentThermalSensation => apparentTemperature[currentHour];

}

class HourlyUnits {

  String? time;
  String? temperatureM;
  String? precipitationProbability;
  String? cloudiness;
  String? windSpeed;

  HourlyUnits({
    this.time,
    this.temperatureM,
    this.precipitationProbability,
    this.cloudiness,
    this.windSpeed,
  });

  factory HourlyUnits.fromJson(Map<String, dynamic> json) => HourlyUnits(
    time: json["time"],
    temperatureM: json["temperature_2m"],
    precipitationProbability: json["precipitation_probability"],
    cloudiness: json["cloudcover"],
    windSpeed: json["windspeed_10m"],
  );

}