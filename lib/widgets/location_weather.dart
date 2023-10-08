import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:weather_app/theme/app_theme.dart';

class LocationWeather extends StatelessWidget {

  final String location;
  final String weatherDescription;

  const LocationWeather({
    super.key, 
    required this.location, 
    required this.weatherDescription
  });

  @override
  Widget build(BuildContext context) {
    final String locationDescription = location.toUpperCase();

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text(locationDescription, style: AppTheme().textSizeNormalBold, textAlign: TextAlign.center),
          SizedBox(height: 8.h),
          Text(weatherDescription, style: AppTheme().textSizeNormal),
        ],
      ),
    );
  }

}