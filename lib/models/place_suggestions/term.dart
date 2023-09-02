
class Term {
  int offset;
  String value;

  Term({
    required this.offset,
    required this.value,
  });

  factory Term.fromJson(Map<String, dynamic> json) => Term(
    offset: json["offset"],
    value: json["value"],
  );

}