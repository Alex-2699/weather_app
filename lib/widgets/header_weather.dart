import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:weather_app/theme/app_theme.dart';

class HeaderWeatherStatistics extends StatelessWidget {
  
  final int cloudiness;
  final int humidity;
  final double windSpeed;

  const HeaderWeatherStatistics({
    super.key, 
    required this.cloudiness, 
    required this.humidity,
    required this.windSpeed, 
  });

  Widget _buildWeatherInfoItem(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 25.h, color: AppTheme.primaryTextColor),
        SizedBox(width: 8.w),
        Text(value, style: AppTheme.textSizeNormal),
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
          _buildWeatherInfoItem(Icons.cloud_queue_rounded, '$cloudiness%'),
          _buildWeatherInfoItem(Icons.air_rounded, '$windSpeed/s'),
          _buildWeatherInfoItem(Icons.water_drop_outlined, '$humidity%'),
        ],
      ),
    );
  }
}