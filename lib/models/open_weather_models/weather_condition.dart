class WeatherCondition {

  int id;
  String main;
  String description;
  String icon;

  WeatherCondition({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherCondition.fromJson(Map<String, dynamic> json) => WeatherCondition(
    id: json["id"],
    main: json["main"],
    description: json["description"],
    icon: json["icon"],
  );

  get iconImageUrl => 'https://openweathermap.org/img/wn/$icon@4x.png';

}