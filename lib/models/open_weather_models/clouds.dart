class Clouds {
  int cloudiness;

  Clouds({required this.cloudiness,});

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
    cloudiness: json["all"],
  );

}