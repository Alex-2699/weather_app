import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:weather_app/providers/providers.dart';

class CurrentWeather extends ConsumerWidget {

  final int temp;
  final int tempMax;
  final int tempMin;

  const CurrentWeather({
    super.key, 
    required this.temp, 
    required this.tempMax, 
    required this.tempMin,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(appThemeProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$temp', style: appTheme.textSizeExtraLarge),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('°c', style: appTheme.textSizeLarge),
            _MaxAndMinTemperature(arrowIndicator: Icons.arrow_drop_up_rounded, temp: '$tempMax° ', tempIndicator: 'MAX'),
            _MaxAndMinTemperature(arrowIndicator: Icons.arrow_drop_down_rounded, temp: '$tempMin° ', tempIndicator: 'MIN'),
          ],
        ),
      ],
    );
  }

}

class _MaxAndMinTemperature extends ConsumerWidget {
  const _MaxAndMinTemperature({
    required this.arrowIndicator,
    required this.temp,
    required this.tempIndicator,
  });

  final IconData arrowIndicator;
  final String temp;
  final String tempIndicator;

  @override
  Widget build(BuildContext context, WidgetRef ref ) {
    final appTheme = ref.watch(appThemeProvider);

    return Row(
      children: [
        Icon(arrowIndicator, size: 30.sp, color: appTheme.primaryTextColor.withOpacity(0.7)),
        Text(temp, style: appTheme.textSizeNormal),
        Text(tempIndicator, style: appTheme.textSizeSmall),
      ],
    );
  }

}
