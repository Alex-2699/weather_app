import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:weather_app/models/models.dart';
import 'package:weather_app/providers/location_search_provider.dart';

import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/widgets/resources/resources.dart';
import 'package:weather_app/widgets/widgets.dart';

class SearchLocation extends ConsumerWidget {
  const SearchLocation({super.key});

  void setLocationNameInput(WidgetRef ref, String locationName) {
    ref.read(locationNameProvider.notifier).update((state) => state = locationName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const AppBarCustom(title: 'Buscar ciudad'),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          child: Column(
            children: [
              InputText(
                prefixIcon: Icons.search_rounded, 
                onChange:(locationName) => setLocationNameInput(ref, locationName)
              ),
              Divider(height: 30.h, thickness: 1),
              _BuildSuggestions(),
            ],
          ),
        ),
      ),
    );
  }

}

class _BuildSuggestions extends ConsumerWidget {

  void _onTapLocation(BuildContext context, WidgetRef ref, Prediction place) async {
      final coordinatesProvider = ref.read(getPlaceCordinatesProvider(place.placeId));
    try {

      _navigateToHomeScreen(context, place.description, coordinatesProvider.asData!.value);
    } catch (error) {
      showErrorSnackbar(context, coordinatesProvider.error.toString());
    }
  }

  void _navigateToHomeScreen(BuildContext context, String locationName, Location coordinates) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => HomeScreen(
    //       locationName: locationName,
    //       latitude: coordinates.lat, 
    //       longitude: coordinates.lng,
    //     ),
    //   ),
    // );
  }

  Widget _listViewSuggestions(BuildContext context, WidgetRef ref, SuggestionsResponse suggestions) {
    return Expanded(
      child: ListView.separated(
        itemCount: suggestions.predictions.length,
        itemBuilder: (_, i) {
          return SuggestionItem(
            description: suggestions.predictions[i].description,
            onTap:() => _onTapLocation(context, ref, suggestions.predictions[i]),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suggestionsProvider = ref.watch(searchLocationProvider);

    return Container(
      child: suggestionsProvider.when(
        data: (data) => _listViewSuggestions(context, ref, data), 
        error: (error, stackTrace) => Text('Error: $error'), 
        loading: () => CustomProgressIndicator.staggeredDotsWaveDark(),
      )
    );
  }

}
