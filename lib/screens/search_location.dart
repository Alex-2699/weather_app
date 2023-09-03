import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:weather_app/models/models.dart';

import 'package:weather_app/providers/providers.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/widgets/widgets.dart';

class SearchLocation extends StatelessWidget {
  const SearchLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<LocationSearchProvider>(context, listen: false);

    return Scaffold(
      appBar: const AppBarCustom(title: 'Buscar ciudad'),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          child: Column(
            children: [
              InputText(
                prefixIcon: Icons.search_rounded, 
                onChange:(locationName) => searchProvider.getPlaceSuggestions(locationName),
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

class _BuildSuggestions extends StatelessWidget {

  void onTapLocation(BuildContext context, Prediction prediction) async {
    final searchProvider = Provider.of<LocationSearchProvider>(context, listen: false);

    try {
      await searchProvider.getLocationCoordinates(prediction.placeId);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            locationName: prediction.description,
            latitude: searchProvider.coordinates.result.geometry.location.lat, 
            longitude: searchProvider.coordinates.result.geometry.location.lng,
          ),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<LocationSearchProvider>(context);

    return Expanded(
      child: ListView.separated(
        itemCount: searchProvider.placeSuggestions.predictions.length,
        itemBuilder: (_, i) {
          return SuggestionItem(
            description: searchProvider.placeSuggestions.predictions[i].description,
            onTap:() => onTapLocation(context, searchProvider.placeSuggestions.predictions[i]),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
