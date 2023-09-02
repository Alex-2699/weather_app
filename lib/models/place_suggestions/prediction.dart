
import 'package:weather_app/models/models.dart';

class Prediction {

  String description;
  List<MatchedSubstring> matchedSubstrings;
  String placeId;
  String reference;
  StructuredFormatting structuredFormatting;
  // List<Term> terms;
  // List<Type> types;

  Prediction({
    required this.description,
    required this.matchedSubstrings,
    required this.placeId,
    required this.reference,
    required this.structuredFormatting,
    // required this.terms,
    // required this.types,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) => Prediction(
    description: json["description"],
    matchedSubstrings: List<MatchedSubstring>.from(json["matched_substrings"].map((x) => MatchedSubstring.fromJson(x))),
    placeId: json["place_id"],
    reference: json["reference"],
    structuredFormatting: StructuredFormatting.fromJson(json["structured_formatting"]),
    // terms: List<Term>.from(json["terms"].map((x) => Term.fromJson(x))),
    // types: List<Type>.from(json["types"].map((x) => typeValues.map[x])),
  );

}