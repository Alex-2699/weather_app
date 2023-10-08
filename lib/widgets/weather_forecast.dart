import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather_app/providers/providers.dart';
import 'package:weather_app/theme/app_theme.dart';
import 'package:weather_app/utils/utils.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherForecast extends StatelessWidget {
  final bool isHourly;

  const WeatherForecast({super.key, required this.isHourly});

  Future<void> _autoScrollToIndex(ScrollController controller, BuildContext context) async {
    final forecastProvider = Provider.of<WeatherForecastProvider>(context, listen: false);

    if(!forecastProvider.hasScrolledToIndex) {
      final int index = isHourly ? forecastProvider.currentHour : forecastProvider.selectedDayIndex;

      await controller.animateTo(
        index * 110.w,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      await forecastProvider.updateScrolledToIndex(true);
    }
  }

  String _getTimeHeader(WeatherForecastProvider forecastProvider, int index) {
    final String dateTimeFormat = isHourly ? 'h:00 a' : 'EEEE';

    final String dateTime = isHourly
        ? forecastProvider.hourlyWeather.time[index]
        : forecastProvider.dailyWeather.time[index];

    return DateAndTimeFormat.formatDateTime(dateTime, dateTimeFormat);
  }

  IconData _getWeatherIcon(WeatherForecastProvider forecastProvider, int index) {
    final position = index + (24 * (forecastProvider.selectedDayIndex));

    final int sunriseHour = DateAndTimeFormat.getHourFromDate(forecastProvider.isoSunriseDate);
    final int sunsetHour = DateAndTimeFormat.getHourFromDate(forecastProvider.isoSunsetDate);

    final int hourStamp = DateAndTimeFormat.getHourFromDate(forecastProvider.hourlyWeather.time[position]);

    final int weatherIconCode = isHourly
        ? forecastProvider.hourlyWeather.weathercode[position]
        : forecastProvider.dailyWeather.weathercode[index];

    if(!isHourly) return WeatherData.weatherIconsDayTime[weatherIconCode]!;

    if (hourStamp >= sunriseHour && hourStamp <= sunsetHour) {
      return WeatherData.weatherIconsDayTime[weatherIconCode]!; 
    }
    return WeatherData.weatherIconsNightTime[weatherIconCode]!; 
  }

  String _getTemperatureFooter(WeatherForecastProvider forecastProvider, int index) {
    final position = index + (24 * (forecastProvider.selectedDayIndex));

    int temp = isHourly ? forecastProvider.hourlyWeather.temperature[position] : 0; 

    int tempMin = !isHourly ? forecastProvider.dailyWeather.tempMin[index] : 0; 
    int tempMax = !isHourly ? forecastProvider.dailyWeather.tempMax[index] : 0; 

    return isHourly ? '$temp°' : '$tempMax° | $tempMin°';
  }

  Widget _buildListForecastItems(ScrollController controller, BuildContext context) {
    final forecastProvider = Provider.of<WeatherForecastProvider>(context);

    int listItemCount = isHourly 
      ? 24
      : forecastProvider.dailyWeather.time.length;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: ListView.separated(
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemCount: listItemCount,
        itemBuilder: (_, i) => _ForecastItem(
          timeHeader: _getTimeHeader(forecastProvider, i),
          weatherIcon: _getWeatherIcon(forecastProvider, i),
          temperatureFooter: _getTemperatureFooter(forecastProvider, i),
          isHourly: isHourly,
          index: i -1,
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
        WidgetsBinding.instance.addPostFrameCallback((_) => _autoScrollToIndex(controller, context));

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
          width: double.infinity,
          height: 120.h,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.18),
            borderRadius: BorderRadius.circular(20),
          ),
          child: _buildListForecastItems(controller, context),
        );
      },
    );
  }

}

class _ForecastItem extends StatelessWidget {

  final String timeHeader;
  final String temperatureFooter;
  final IconData weatherIcon;
  final bool isHourly;
  final int index;

  const _ForecastItem({
    required this.timeHeader, 
    required this.temperatureFooter, 
    required this.weatherIcon, 
    required this.isHourly,
    required this.index, 
  });

  bool _shadeItem(WeatherForecastProvider forecastProvider) {
    final int currentHour = forecastProvider.currentHour;
    final int daySelectIndex = forecastProvider.selectedDayIndex -1;

    if(isHourly && daySelectIndex +1 == 0) return currentHour == index; 
    if(isHourly) return false; 
    
    return daySelectIndex == index;
  }

  void _onTapDayItem(WeatherForecastProvider forecastProvider) {
    if(!isHourly) forecastProvider.updateSelectedDayIndex(index + 1);
  }

  @override
  Widget build(BuildContext context) {
    final forecastProvider = Provider.of<WeatherForecastProvider>(context);

    return InkWell(
      child: Container(
        width: 100.w,
        decoration: BoxDecoration(
          color: _shadeItem(forecastProvider) ? Colors.black.withOpacity(0.18) : null,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(timeHeader, style: AppTheme().textSizeSmall),
            BoxedIcon(weatherIcon, color: Colors.white, size: 35.sp),
            Text(temperatureFooter, style: AppTheme().textSizeSmall),
          ],
        ),
      ),
      onTap: () => _onTapDayItem(forecastProvider),
    );
  }

}