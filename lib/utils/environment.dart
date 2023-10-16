import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {

  static const String openMeteoUrl = 'api.open-meteo.com';
  static const String googleApiUrl = 'maps.googleapis.com';

  static final String? googlePlacesApiKey = dotenv.env['GOOGLE_PLACES_API_KEY'];

}