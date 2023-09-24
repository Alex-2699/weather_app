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
  final String? isoSunriseDate;
  final String? isoSunsetDate;
  final int? currentHour;
  bool isHourly = false;

  WeatherForecastDisplay({
    Key? key,
    required this.headerLabel,
    this.daylyWeather, 
    this.hourlyWeather,
    this.isoSunriseDate, 
    this.isoSunsetDate, 
    this.currentHour,
  }) : super(key: key) {
    isHourly = hourlyWeather != null;
  }

  Future<void> scrollToIndex(ScrollController controller, int index) async {
    await controller.animateTo(
      index * 110.w,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  int extractHour(String? isoDate) {
    if (isoDate == null) return 0;
    
    final dateTime = DateTime.parse(isoDate);
    return dateTime.hour;
  }

  Widget _buildListForecastItems(ScrollController controller) {
    final List<String> timestamps = isHourly ? hourlyWeather!.time : daylyWeather!.time;
    final List<int> weatherCodes = isHourly ? hourlyWeather!.weathercode : daylyWeather!.weathercode;

    final List<int>? temperatureMarks = isHourly ? hourlyWeather!.temperature : null;
    final List<int>? maxTempMarks = !isHourly ? daylyWeather!.tempMax : null;
    final List<int>? minTempMarks = !isHourly ? daylyWeather!.tempMin : null;

    final int sunriseHour = extractHour(isoSunriseDate);
    final int sunsetHour = extractHour(isoSunsetDate);

    final bool isCurrentHour = isHourly; 

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: ListView.separated(
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemCount: timestamps.length,
        itemBuilder: (_, i) => _ForecastItem(
          time: timestamps[i],
          weatherCode: weatherCodes[i],
          temperature: temperatureMarks?[i],
          tempMax: maxTempMarks?[i],
          tempMin: minTempMarks?[i],
          sunriseHour: sunriseHour,
          sunsetHour: sunsetHour,
          isCurrentHour: isCurrentHour ?  currentHour == i -1 : false,
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
          WidgetsBinding.instance.addPostFrameCallback((_) => scrollToIndex(controller, currentHour ?? 0));
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
  final int sunriseHour;
  final int sunsetHour;
  final bool isCurrentHour;

  const _ForecastItem({ 
    required this.time, 
    required this.weatherCode, 
    required this.sunriseHour, 
    required this.sunsetHour,
    required this.isCurrentHour, 
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
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
        color: isCurrentHour ? Colors.black.withOpacity(0.18) : null,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTimeStamp(),
          _buildWeatherIcon(),
          _buildTempStamp()
        ],
      ),
    );
  }

  Widget _buildWeatherIcon() {
    if(sunriseHour == 0) {
      return BoxedIcon(
        WeatherData.weatherIconsDayTime[weatherCode]!, 
        color: Colors.white, 
        size: 35.sp,
      );
    }
      
    final int hourStamp = DateAndTimeFormat.getHourFromDate(time);
    
    if (hourStamp >= sunriseHour && hourStamp <= sunsetHour) {
      return BoxedIcon(
        WeatherData.weatherIconsDayTime[weatherCode]!, 
        color: Colors.white, 
        size: 35.sp,
      );
    } else {
       return BoxedIcon(
        WeatherData.weatherIconsNightTime[weatherCode]!, 
        color: Colors.white, 
        size: 35.sp,
      );
    }
  } 

}