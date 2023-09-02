import 'dart:async';

import 'package:flutter/material.dart';

import 'package:weather_app/models/models.dart';
import 'package:weather_app/utils/utils.dart';

class LocationSearchProvider extends ChangeNotifier {

  SuggestionsResponse placeSuggestions = SuggestionsResponse(predictions: [], status: 'initial');
  Timer debounceTimer = Timer(Duration.zero, () {});

  Future getPlaceSuggestions(String locationName) async {
    if (debounceTimer.isActive) debounceTimer.cancel();
    
    debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final String jsonData = await ApiService().getJsonData(Environment.googleApiUrl, 'maps/api/place/autocomplete/json', {
        'key': Environment.googlePlacesApiKey,
        'input': locationName,
        'language': 'es',
        'types': 'locality'
      });

      placeSuggestions = SuggestionsResponse.fromJson(jsonData);
      notifyListeners();
    });

  }

  SuggestionsResponse get suggestions => placeSuggestions;

}