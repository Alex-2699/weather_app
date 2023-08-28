class WindCondition {

  double speed;
  int direction;
  double gust;

  WindCondition({
    required this.speed,
    required this.direction,
    required this.gust,
  });

  factory WindCondition.fromJson(Map<String, dynamic> json) => WindCondition(
    speed: json["speed"]?.toDouble(),
    direction: json["deg"],
    gust: json["gust"]?.toDouble(),
  );

}