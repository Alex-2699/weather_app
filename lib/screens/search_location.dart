import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import 'package:weather_app/providers/providers.dart';
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

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<LocationSearchProvider>(context);

    return Expanded(
      child: ListView.separated(
        itemCount: searchProvider.placeSuggestions.predictions.length,
        itemBuilder: (_, i) => SuggestionItem(description: searchProvider.placeSuggestions.predictions[i].description),
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
