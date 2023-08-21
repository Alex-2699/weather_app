import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {

  static const lightPrimary = Color.fromRGBO(141,209,217, 1);
  static const lightSecondary = Color.fromRGBO(120,199,209,1);

  static const darkPrimary = Color.fromRGBO(96,103,117, 1);
  static const darkSecondary = Color.fromRGBO(61,67,83,1);

  static const primaryTextColor = Colors.white;

  static const lightMountain1 = Color.fromRGBO(158, 217, 225, 1);
  static const lightMountain2 = Color.fromRGBO(124, 195, 204, 1);
  static const lightMountain3 = Color.fromRGBO(93, 164, 173, 1);
  static const lightMountain4 = Color.fromRGBO(62, 135, 143, 1);
  static const lightMountain5 = Color.fromRGBO(26, 106, 114, 1);

  static const darkMountain1 = Color.fromRGBO(153, 162, 179, 1);
  static const darkMountain2 = Color.fromRGBO(123, 131, 147, 1);
  static const darkMountain3 = Color.fromRGBO(94, 102, 118, 1);
  static const darkMountain4 = Color.fromRGBO(67, 75, 90, 1);
  static const darkMountain5 = Color.fromRGBO(42, 50, 74, 1);

  static const List<Color> lightGradient = [
    lightPrimary,
    lightSecondary
  ];

  static const List<Color> darkGradient = [
    darkPrimary,
    darkSecondary
  ];

  static TextStyle textSizeSmall = TextStyle(
    color: primaryTextColor,
    fontSize: 14.sp,
  );

  static TextStyle textSizeNormal = TextStyle(
    color: primaryTextColor,
    fontSize: 18.sp,
  );

  static TextStyle textSizeLarge = TextStyle(
    color: primaryTextColor,
    fontSize: 40.sp,
  );

  static TextStyle textSizeExtraLarge = TextStyle(
    color: primaryTextColor,
    fontSize: 120.sp,
  );

  static TextStyle textSizeNormalBold = TextStyle(
    color: primaryTextColor,
    fontWeight: FontWeight.bold,
    fontSize: 18.sp,
  );

  static ThemeData globalTheme = ThemeData.light().copyWith(
    platform: TargetPlatform.iOS,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    ),
  );

}