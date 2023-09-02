import 'dart:convert';

import 'package:weather_app/models/models.dart';

class SuggestionsResponse {

  List<Prediction> predictions;
  String status;

  SuggestionsResponse({
    required this.predictions,
    required this.status,
  });

  factory SuggestionsResponse.fromJson(String str) => SuggestionsResponse.fromMap(json.decode(str));

  factory SuggestionsResponse.fromMap(Map<String, dynamic> json) => SuggestionsResponse(
    predictions: List<Prediction>.from(json["predictions"].map((x) => Prediction.fromJson(x))),
    status: json["status"],
  );

}

