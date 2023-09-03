import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:weather_app/models/models.dart';
import 'package:weather_app/utils/utils.dart';

class LocationSearchProvider extends ChangeNotifier {

  String? googlePlacesApiKey = dotenv.env['GOOGLE_PLACES_API_KEY'];
  
  SuggestionsResponse placeSuggestions = SuggestionsResponse(predictions: [], status: 'initial');
  CoordinatesResponse locationCoordinates = CoordinatesResponse(result: Result(geometry: Geometry(location: Location(lat: 0.0, lng: 0.0))), status: 'initial');

  Timer debounceTimer = Timer(Duration.zero, () {});

  Future getPlaceSuggestions(String locationName) async {
    if (debounceTimer.isActive) debounceTimer.cancel();
    
    debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final String jsonData = await ApiService().getJsonData(Environment.googleApiUrl, 'maps/api/place/autocomplete/json', {
        'key': googlePlacesApiKey ?? '',
        'input': locationName,
        'language': 'es',
        'types': 'locality'
      });

      placeSuggestions = SuggestionsResponse.fromJson(jsonData);
      notifyListeners();
    });

  }

  Future<dynamic> getLocationCoordinates(String locationId) async {
    final String jsonData = await ApiService().getJsonData(Environment.googleApiUrl, 'maps/api/place/details/json', {
      'key': googlePlacesApiKey ?? '',
      'place_id': locationId,
      'fields': 'geometry',
    });

    locationCoordinates = CoordinatesResponse.fromJson(jsonData);
    notifyListeners();
  }

  SuggestionsResponse get suggestions => placeSuggestions;
  CoordinatesResponse get coordinates => locationCoordinates;

}