import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:weather_app/models/models.dart';
import 'package:weather_app/providers/location_search_provider.dart';

import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/utils/utils.dart';
import 'package:weather_app/widgets/widgets.dart';

class SearchLocation extends ConsumerWidget {
  const SearchLocation({super.key});

  void setLocationNameInput(WidgetRef ref, String locationName) {
    ref.read(locationNameProvider.notifier).state = locationName;
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

  Future<void> _onTapLocation(BuildContext context, WidgetRef ref, Prediction place) async {
    await ref.read(getPlaceCordinatesProvider(place.placeId).future);
    _navigateToHomeScreen(context, place.description);
  }

  void _navigateToHomeScreen(BuildContext context, String locationName) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(locationName: locationName)),
    );
  }

  Widget _listViewSuggestions(BuildContext context, WidgetRef ref, SuggestionsResponse suggestions) {
    if(suggestions.predictions.isEmpty) return const Text('No hay resultados');
    
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
    final suggestions = ref.watch(searchLocationProvider(locationName));

    return Container(
      child: RequestStateEvaluator(
        dataProvider: suggestions,
        onDataHasLoaded: (data) => _listViewSuggestions(context, ref, data),
      ).evaluateRequest(CustomProgressIndicator.staggeredDotsWaveDark())
    );
  }

}
