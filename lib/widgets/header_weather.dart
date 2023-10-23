import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:weather_app/providers/providers.dart';

class HeaderWeatherStatistics extends StatelessWidget {
  
  final int thermalSensation;
  final int precipitationPercent;
  final int windSpeedPercent;

  const HeaderWeatherStatistics({
    super.key, 
    required this.thermalSensation, 
    required this.precipitationPercent,
    required this.windSpeedPercent, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.h, bottom: 40.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          WeatherInfoItem(weatherConditionIcon: Icons.thermostat_rounded, percentage: '$thermalSensation°'),
          WeatherInfoItem(weatherConditionIcon: Icons.air_rounded, percentage: '$windSpeedPercent km/h'),
          WeatherInfoItem(weatherConditionIcon: Icons.water_drop_outlined, percentage: '$precipitationPercent%'),
        ],
      ),
    );
  }

}

class WeatherInfoItem extends ConsumerWidget {
  const WeatherInfoItem({
    super.key,
    required this.weatherConditionIcon,
    required this.percentage,
  });

  final IconData weatherConditionIcon;
  final String percentage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(appThemeProvider);

    return Row(
      children: [
        Icon(weatherConditionIcon, size: 25.sp, color: appTheme.primaryTextColor),
        SizedBox(width: 8.w),
        Text(percentage, style: appTheme.textSizeNormal),
      ],
    );
  }

}