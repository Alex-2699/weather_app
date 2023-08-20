import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:weather_app/theme/app_theme.dart';
import 'package:weather_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _buildScreen() {
    return Stack(
      children: [
        const GradientDecoration(),
        const Align(alignment: Alignment.bottomCenter, child: MountainBackground()),
        SafeArea(
          child: Column(
            children: [
              const HeaderWeatherStatistics(
                cloudiness: 66,
                humidity: 55,
                windSpeed: 2.72,
              ),
              const CurrentLocationWeather(
                temp: 32,
                tempMax: 36,
                tempMin: 24,
                country: 'mx',
                location: 'San Juan Bautista Tuxtepec',
                weatherDescription: 'Tormenta eléctrica',
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
      body: _buildScreen(),
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
