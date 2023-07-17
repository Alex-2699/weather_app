import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:weather_app/theme/app_theme.dart';
import 'package:weather_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _body() {
    return Stack(
      children: [
        const GradientDecoration(),
        Align(
          alignment: Alignment.bottomCenter,
          child: MountainWidget(),
        ),
        SafeArea(
          child: Column(
            children: [
              const _HeaderWeather(
                cloudiness: 66,
                humidity: 55,
                windSpeed: 2.72,
              ),
              const CurrentWeather(
                temp: 32,
                tempMax: 36,
                tempMin: 24,
                country: 'mx',
                location: 'San Juan Bautista Tuxtepec',
                weather: 'Tormenta eléctrica',
              ),
              _IconHeader(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }
}

class _HeaderWeather extends StatelessWidget {
  
  final int cloudiness;
  final double windSpeed;
  final int humidity;

  const _HeaderWeather({
    required this.cloudiness, 
    required this.windSpeed, 
    required this.humidity
  });

  Widget _buildItem(IconData icon, String value) {
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
          _buildItem(Icons.cloud_queue_rounded, '$cloudiness%'),
          _buildItem(Icons.air_rounded, '$windSpeed/s'),
          _buildItem(Icons.water_drop_outlined, '$humidity%'),
        ],
      ),
    );
  }
}

class _IconHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 40.h),
      child: Icon(Icons.cloud_queue_rounded, size: 120.h, color: AppTheme.primaryTextColor)
    );
  }
}
