import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:weather_app/theme/app_theme.dart';

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

  Widget _buildWeatherInfoItem(IconData weatherConditionIcon, String percentage) {
    return Row(
      children: [
        Icon(weatherConditionIcon, size: 25.sp, color: AppTheme().primaryTextColor),
        SizedBox(width: 8.w),
        Text(percentage, style: AppTheme().textSizeNormal),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.h, bottom: 40.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildWeatherInfoItem(Icons.thermostat_rounded, '$thermalSensation°'),
          _buildWeatherInfoItem(Icons.air_rounded, '$windSpeedPercent km/h'),
          _buildWeatherInfoItem(Icons.water_drop_outlined, '$precipitationPercent%'),
        ],
      ),
    );
  }

}