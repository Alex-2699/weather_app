import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/models/models.dart';

import 'package:weather_app/theme/app_theme.dart';
import 'package:weather_app/utils/utils.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherForecastDisplay extends StatelessWidget {

  final String headerLabel;
  final HourlyDto? hourlyWeather;
  final DailyDto? daylyWeather;
  bool isHourly = false;

  WeatherForecastDisplay({
    Key? key,
    required this.headerLabel,
    this.hourlyWeather,
    this.daylyWeather,
  }) : super(key: key) {
    isHourly = hourlyWeather != null;
  }

  //TODO: Refactorizar esta clase

  Future<void> scrollToIndex(ScrollController controller, int index) async {
    await controller.animateTo(
      index * 110.w,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildListForecastItems(ScrollController controller) {
    final int lenght = isHourly ? hourlyWeather!.time.length : daylyWeather!.time.length;

    final List<String> timestamps = isHourly ? hourlyWeather!.time : daylyWeather!.time;
    final List<int> weatherCodes = isHourly ? hourlyWeather!.weathercode : daylyWeather!.weathercode;

    final List<int>? temperatureMarks = isHourly ? hourlyWeather!.temperature : null;
    final List<int>? maxTempMarks = !isHourly ? daylyWeather!.tempMax : null;
    final List<int>? minTempMarks = !isHourly ? daylyWeather!.tempMin : null;


    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: ListView.separated(
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemCount: lenght,
        itemBuilder: (_, i) => _ForecastItem(
          time: timestamps[i],
          weatherCode: weatherCodes[i],
          temperature: isHourly ? temperatureMarks![i] : null,
          tempMax: !isHourly ? maxTempMarks![i] : null,
          tempMin: !isHourly ? minTempMarks![i] : null,
        ),
        separatorBuilder: (_, i) => SizedBox(width: 10.w),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController controller = ScrollController();
    
    return LayoutBuilder(
      builder: (context, constraints) {

        if (isHourly) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            scrollToIndex(controller, 15);
          });
        }

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(headerLabel, style: AppTheme.textSizeNormal),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                width: double.infinity,
                height: 120.h,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: _buildListForecastItems(controller),
              ),
            ],
          ),
        );
      },
    );
  }

}

class _ForecastItem extends StatelessWidget {

  final String time;
  final int? temperature;
  final int? tempMax;
  final int? tempMin;
  final int weatherCode;

  const _ForecastItem({ 
    required this.time, 
    required this.weatherCode, 
    this.temperature, 
    this.tempMax, 
    this.tempMin,
  });

  Widget _buildTimeStamp() {
    String dateTimeFormat = temperature == null ? 'EEEE' : 'h:00 a';

    return Text(
      DateAndTimeFormat.formatDateTime(time, dateTimeFormat), 
      style: AppTheme.textSizeSmall,
    );
  } 

  Widget _buildTempStamp() {
    String temperatureIndicator = temperature == null 
    ? '$tempMax° | $tempMin°' 
    : '$temperature°';

    return Text(temperatureIndicator, style: AppTheme.textSizeSmall);
  } 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTimeStamp(),
          BoxedIcon(WeatherData.weatherIconsDayTime[weatherCode]!, color: Colors.white, size: 35.sp),
          _buildTempStamp()
        ],
      ),
    );
  }

}