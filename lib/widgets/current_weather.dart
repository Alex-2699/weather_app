import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:weather_app/theme/app_theme.dart';

class CurrentWeather extends StatelessWidget {

  final int temp;
  final int tempMax;
  final int tempMin;

  const CurrentWeather({
    super.key, 
    required this.temp, 
    required this.tempMax, 
    required this.tempMin,
  });

  Widget _buildMaxAndMinTemp(IconData arrowIndicator, String temp, String tempIndicator) {
    return Row(
      children: [
        Icon(arrowIndicator, size: 30.sp, color: AppTheme().primaryTextColor.withOpacity(0.7)),
        Text(temp, style: AppTheme().textSizeNormal),
        Text(tempIndicator, style: AppTheme().textSizeSmall),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$temp', style: AppTheme().textSizeExtraLarge),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('°c', style: AppTheme().textSizeLarge),
            _buildMaxAndMinTemp(Icons.arrow_drop_up_rounded, '$tempMax° ', 'MAX'),
            _buildMaxAndMinTemp(Icons.arrow_drop_down_rounded, '$tempMin° ', 'MIN'),
          ],
        ),
      ],
    );
  }

}
