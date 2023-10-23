import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:weather_app/providers/providers.dart';

class LocationWeather extends ConsumerWidget {

  final String location;
  final String weatherDescription;

  const LocationWeather({
    super.key, 
    required this.location, 
    required this.weatherDescription
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(appThemeProvider);

    final String locationDescription = location.toUpperCase();

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text(locationDescription, style: appTheme.textSizeNormalBold, textAlign: TextAlign.center),
          SizedBox(height: 8.h),
          Text(weatherDescription, style: appTheme.textSizeNormal),
        ],
      ),
    );
  }

}