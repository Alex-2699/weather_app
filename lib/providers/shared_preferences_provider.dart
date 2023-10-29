import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


final getDefaultLocationProvider = FutureProvider<List<String>?>((ref) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getStringList('default_location');
});

final locationPropertiesProvider = StateProvider<LocationProperties>((ref) {
  return LocationProperties(placeId: 'locationId', placeName: 'locationName', isDefaultLocation: true);
});

final setDefaultLocationProvider = FutureProvider.autoDispose.family<void, String>((ref, placeId) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final locationProperties = ref.read(locationPropertiesProvider);

  final defaultLocation =  prefs.getStringList('default_location');
  defaultLocation ?? await prefs.setStringList('default_location', [locationProperties.placeId, locationProperties.placeName]);

  if(defaultLocation != null) {
    defaultLocation[0] == placeId
      ? ref.read(locationPropertiesProvider.notifier).state.isDefaultLocation = true
      : ref.read(locationPropertiesProvider.notifier).state.isDefaultLocation = false;
  }
});


class LocationProperties {

  final String placeId;
  final String placeName;
  bool isDefaultLocation;

  LocationProperties({
    required this.placeId, 
    required this.placeName,
    this.isDefaultLocation = false,
  });

}
