import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:weather_app/theme/app_theme.dart';

class CurrentWeather extends StatelessWidget {

  final int temp;
  final int tempMax;
  final int tempMin;
  final String location;
  final String country;
  final String weather;

  const CurrentWeather({
    super.key, 
    required this.temp, 
    required this.tempMax, 
    required this.tempMin, 
    required this.location, 
    required this.country, 
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _DataWeather(temp: temp, tempMax: tempMax, tempMin: tempMin),
        _Location(location: location, country: country, weather: weather),
      ],
    );
  }
}

class _DataWeather extends StatelessWidget {

  final int temp;
  final int tempMax;
  final int tempMin;

  const _DataWeather({
    required this.temp, 
    required this.tempMax, 
    required this.tempMin
  });

  Widget _maxAndMinTemp(IconData? icon, String value, TextStyle style, String? temp) {
    return Row(
      children: [
        if(icon != null)
        Icon(icon, size: 30.sp, color: AppTheme.primaryTextColor.withOpacity(0.7)),
        Text(value, style: style),
        Text(temp ?? '', style: AppTheme.textSizeSmall),
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
            _maxAndMinTemp(null, '°c', AppTheme.textSizeLarge, null),
            _maxAndMinTemp(Icons.arrow_drop_up_rounded, '$tempMax°', AppTheme.textSizeNormal, ' MAX'),
            _maxAndMinTemp(Icons.arrow_drop_down_rounded, '$tempMin°', AppTheme.textSizeNormal, ' MIN'),
          ],
        ),
      ],
    );
  }
}

class _Location extends StatelessWidget {

  final String location;
  final String country;
  final String weather;

  const _Location({
    required this.location, 
    required this.country, 
    required this.weather
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${location.toUpperCase()}, ', style: AppTheme.textSizeNormalBold),
              Text(country.toUpperCase(), style: AppTheme.textSizeNormalBold),
            ],
          ),
          Text(weather, style: AppTheme.textSizeNormal),
        ],
      ),
    );
  }
}
