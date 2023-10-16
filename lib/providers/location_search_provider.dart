import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_app/models/models.dart';
import 'package:weather_app/services/search_location_service.dart';


final locationNameProvider = StateProvider<String>((ref) => '');

final searchLocationProvider = FutureProvider<SuggestionsResponse>((ref) async {

  final locationName = ref.watch(locationNameProvider);
  final suggestions = await SearchLocationService.getPlaceSuggestions(locationName);

  return suggestions;
});

final getPlaceCordinatesProvider = FutureProvider.family<Location, String>((ref, placeId) async {

  final coordinates = await SearchLocationService.getLocationCoordinates(placeId);

  return coordinates.result.geometry.location;
});