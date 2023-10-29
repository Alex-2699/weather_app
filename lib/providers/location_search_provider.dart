import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_app/models/models.dart';
import 'package:weather_app/providers/providers.dart';
import 'package:weather_app/services/search_location_service.dart';


final locationNameProvider = StateProvider<String>((ref) => '');

final searchLocationProvider = FutureProvider.family<SuggestionsResponse, String>((ref, locationName) async {
  final suggestions = await SearchLocationService.getPlaceSuggestions(locationName);

  return suggestions;
});


final getPlaceCordinatesProvider = FutureProvider.family.autoDispose<Location, String>((ref, placeId) async {
  final coordinates = await SearchLocationService.getLocationCoordinates(placeId);
  ref.read(coordinatesProvider.notifier).state = coordinates.result.geometry.location;

  ref.read(setDefaultLocationProvider(placeId));

  return coordinates.result.geometry.location;
});
