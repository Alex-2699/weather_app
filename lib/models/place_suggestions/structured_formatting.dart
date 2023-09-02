
import 'package:weather_app/models/models.dart';

class StructuredFormatting {
  String mainText;
  List<MatchedSubstring> mainTextMatchedSubstrings;
  String secondaryText;

  StructuredFormatting({
    required this.mainText,
    required this.mainTextMatchedSubstrings,
    required this.secondaryText,
  });

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) => StructuredFormatting(
    mainText: json["main_text"],
    mainTextMatchedSubstrings: List<MatchedSubstring>.from(json["main_text_matched_substrings"].map((x) => MatchedSubstring.fromJson(x))),
    secondaryText: json["secondary_text"],
  );

}