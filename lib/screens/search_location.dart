import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:weather_app/models/models.dart';
import 'package:weather_app/providers/providers.dart';
import 'package:weather_app/screens/current_weather_screen.dart';
import 'package:weather_app/widgets/widgets.dart';

class SearchLocation extends ConsumerWidget {
  final bool closeScreen;

  const SearchLocation({
    super.key,
    this.closeScreen = false, 
  });

  void setLocationNameInput(WidgetRef ref, String locationName) {
    ref.read(locationNameProvider.notifier).state = locationName;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBarCustom(title: 'Buscar ciudad', closeScreen: closeScreen),
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

  Future<void> _onTapLocation(BuildContext context, WidgetRef ref, Prediction place) async {
    final locationProperties = LocationProperties(placeId: place.placeId, placeName: place.description, isDefaultLocation: true);

    ref.read(locationPropertiesProvider.notifier).state = locationProperties;

    try {
      await ref.read(getPlaceCordinatesProvider(place.placeId).future);
      _navigateToCurrentWeatherScreen(context, place.description);
    } catch (error) {
      _navigateToErrorScreen(context);
    } 
  }

  void _navigateToCurrentWeatherScreen(BuildContext context, String locationName) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const CurrentWeatherScreen()),
    );
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _navigateToErrorScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ErrorScreen(closeScreen: true)),
    );
  }

  Widget _listViewSuggestions(BuildContext context, WidgetRef ref, SuggestionsResponse suggestions) {
    if(suggestions.predictions.isEmpty) return const EmptyOrErrorMessage(isError: false);
    
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
    final locationName = ref.watch(locationNameProvider);
    final suggestionsProv = ref.watch(searchLocationProvider(locationName));

    return Container(
      child: suggestionsProv.when(
        data: (data) => _listViewSuggestions(context, ref, data), 
        loading: () => CustomProgressIndicator.staggeredDotsWaveDark(),
        error: (error, stackTrace) => const EmptyOrErrorMessage(isError: true), 
      )
    );
  }

}
