import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:weather_app/theme/app_theme.dart';

class CurrentLocationWeather extends StatelessWidget {

  final int temp;
  final int tempMax;
  final int tempMin;
  final String country;
  final String location;
  final String weatherDescription;

  const CurrentLocationWeather({
    super.key, 
    required this.country, 
    required this.location, 
    required this.temp, 
    required this.tempMax, 
    required this.tempMin, 
    required this.weatherDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CurrentWeatherData(temp: temp, tempMax: tempMax, tempMin: tempMin),
        _Location(location: location, country: country, weatherDescription: weatherDescription),
      ],
    );
  }

}

class _CurrentWeatherData extends StatelessWidget {

  final int temp;
  final int tempMax;
  final int tempMin;

  const _CurrentWeatherData({
    required this.temp, 
    required this.tempMax, 
    required this.tempMin
  });

  Widget _buildMaxAndMinTemp(IconData arrowIndicator, String temp, String tempIndicator) {
    return Row(
      children: [
        Icon(arrowIndicator, size: 30.sp, color: AppTheme.primaryTextColor.withOpacity(0.7)),
        Text(temp, style: AppTheme.textSizeNormal),
        Text(tempIndicator, style: AppTheme.textSizeSmall),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$temp', style: AppTheme.textSizeExtraLarge),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('°c', style: AppTheme.textSizeLarge),
            _buildMaxAndMinTemp(Icons.arrow_drop_up_rounded, '$tempMax° ', 'MAX'),
            _buildMaxAndMinTemp(Icons.arrow_drop_down_rounded, '$tempMin° ', 'MIN'),
          ],
        ),
      ],
    );
  }

}

class _Location extends StatelessWidget {

  final String country;
  final String location;
  final String weatherDescription;

  const _Location({
    required this.country, 
    required this.location, 
    required this.weatherDescription
  });

  @override
  Widget build(BuildContext context) {
    final String locationDescription = '${location.toUpperCase()}, ${country.toUpperCase()}';

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text(locationDescription, style: AppTheme.textSizeNormalBold, textAlign: TextAlign.center),
          Text(weatherDescription, style: AppTheme.textSizeNormal),
        ],
      ),
    );
  }

}
