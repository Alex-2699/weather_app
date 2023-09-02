
class MatchedSubstring {

  int length;
  int offset;

  MatchedSubstring({
    required this.length,
    required this.offset,
  });

  factory MatchedSubstring.fromJson(Map<String, dynamic> json) => MatchedSubstring(
    length: json["length"],
    offset: json["offset"],
  );

}