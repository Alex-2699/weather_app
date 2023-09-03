import 'dart:convert';

import 'package:weather_app/models/models.dart';

class CoordinatesResponse {

  Result result;
  String status;

  CoordinatesResponse({
    required this.result,
    required this.status,
  });

  factory CoordinatesResponse.fromJson(String str) => CoordinatesResponse.fromMap(json.decode(str));

  factory CoordinatesResponse.fromMap(Map<String, dynamic> json) => CoordinatesResponse(
    result: Result.fromJson(json["result"]),
    status: json["status"],
  );

}
