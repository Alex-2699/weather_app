enum Type {
  // ignore: constant_identifier_names
  GEOCODE,
  // ignore: constant_identifier_names
  LOCALITY,
  // ignore: constant_identifier_names
  POLITICAL
}

final typeValues = EnumValues({
  "geocode": Type.GEOCODE,
  "locality": Type.LOCALITY,
  "political": Type.POLITICAL
});

class EnumValues<T> {

  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
      reverseMap = map.map((k, v) => MapEntry(v, k));
      return reverseMap;
  }
  
}