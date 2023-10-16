import 'dart:async';

import 'package:weather_app/models/models.dart';
import 'package:weather_app/utils/utils.dart';

class SearchLocationService {

  static Timer debounceTimer = Timer(Duration.zero, () {});

  static Future<SuggestionsResponse> getPlaceSuggestions(String locationName) async {
    final completer = Completer<SuggestionsResponse>();
    String jsonData = '';

    if (debounceTimer.isActive) debounceTimer.cancel();
    
    debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      jsonData = await ApiService.getJsonData(Environment.googleApiUrl, 'maps/api/place/autocomplete/json', {
        'key': Environment.googlePlacesApiKey ?? '',
        'input': locationName,
        'language': 'es',
        'types': 'locality'
      });

      completer.complete(SuggestionsResponse.fromJson(jsonData));
    });

    return completer.future;
  }

  static Future<CoordinatesResponse> getLocationCoordinates(String locationId) async {
    final String jsonData = await ApiService.getJsonData(Environment.googleApiUrl, 'maps/api/place/details/json', {
      'key': Environment.googlePlacesApiKey ?? '',
      'place_id': locationId,
      'fields': 'geometry',
    });

    return CoordinatesResponse.fromJson(jsonData);
  }

}