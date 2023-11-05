import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {

  bool _darkModeOn = false;

  static const _lightPrimary = Color.fromRGBO(141, 209, 217, 1);
  static const _lightSecondary = Color.fromRGBO(120, 199, 209,1);

  static const _darkPrimary = Color.fromRGBO(96, 103, 117, 1);
  static const _darkSecondary = Color.fromRGBO(61, 67, 83,1);

  static const _primaryTextColor = Colors.white;

  static const _lightGray = Color.fromRGBO(245, 245, 245, 1);
  static const _mediumGray = Color.fromRGBO(236, 236, 236, 1);
  static const _darkGray = Color.fromRGBO(88, 88, 88, 1);
  static const _deepGray = Color.fromRGBO(37, 37, 37, 1);

  static const _lightMountain1 = Color.fromRGBO(158, 217, 225, 1);
  static const _lightMountain2 = Color.fromRGBO(124, 195, 204, 1);
  static const _lightMountain3 = Color.fromRGBO(93, 164, 173, 1);
  static const _lightMountain4 = Color.fromRGBO(62, 135, 143, 1);
  static const _lightMountain5 = Color.fromRGBO(26, 106, 114, 1);

  static const _darkMountain1 = Color.fromRGBO(153, 162, 179, 1);
  static const _darkMountain2 = Color.fromRGBO(123, 131, 147, 1);
  static const _darkMountain3 = Color.fromRGBO(94, 102, 118, 1);
  static const _darkMountain4 = Color.fromRGBO(67, 75, 90, 1);
  static const _darkMountain5 = Color.fromRGBO(42, 50, 74, 1);

  ThemeData get globalTheme => ThemeData.light().copyWith(
    platform: TargetPlatform.iOS,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 0,
        backgroundColor: _darkMountain3,
        foregroundColor: Colors.white,
      ),
    ),
  );

  Future<void> updateDarkModeValue(bool darkModeOn) async {
    _darkModeOn = darkModeOn;
  }

  List<Color> get backgroundGradient => [
    primaryColor,
    secondaryColor,
  ];

  TextStyle get textSizeSmall => TextStyle(
    fontFamily: 'RedHatText',
    color: primaryTextColor,
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
  );

  TextStyle get textSizeNormal => TextStyle(
    fontFamily: 'RedHatText',
    color: primaryTextColor,
    fontWeight: FontWeight.w400,
    fontSize: 18.sp,
  );

  TextStyle get textSizeLarge => TextStyle(
    fontFamily: 'RedHatText',
    color: primaryTextColor,
    fontWeight: FontWeight.w400,
    fontSize: 40.sp,
  );

  TextStyle get textSizeExtraLarge => TextStyle(
    fontFamily: 'RedHatText',
    color: primaryTextColor,
    fontWeight: FontWeight.w400,
    fontSize: 120.sp,
  );

  TextStyle get textSizeNormalBold => TextStyle(
    fontFamily: 'RedHatText',
    color: primaryTextColor,
    fontWeight: FontWeight.w600,
    fontSize: 18.sp,
  );


  TextStyle get textTitleError => TextStyle(
    color: _darkMountain4,
    fontFamily: 'RedHatText', 
    fontWeight: FontWeight.w800,
    fontSize: 30.sp, 
  );

  TextStyle get textSubtitleError => TextStyle(
    color: _darkMountain2,
    fontFamily: 'RedHatText', 
    fontWeight: FontWeight.w400,
    fontSize: 17.sp, 
  );

  Color get primaryColor => _darkModeOn ? _darkPrimary : _lightPrimary;
  Color get secondaryColor => _darkModeOn ? _darkSecondary : _lightSecondary;
  Color get primaryTextColor => _primaryTextColor;

  Color get mountain1 => _darkModeOn ? _darkMountain1 : _lightMountain1;
  Color get mountain2 => _darkModeOn ? _darkMountain2 : _lightMountain2;
  Color get mountain3 => _darkModeOn ? _darkMountain3 : _lightMountain3;
  Color get mountain4 => _darkModeOn ? _darkMountain4 : _lightMountain4;
  Color get mountain5 => _darkModeOn ? _darkMountain5 : _lightMountain5;

  Color get lightGray => _lightGray;
  Color get mediumGray => _mediumGray;
  Color get darkGray => _darkGray;
  Color get deepGray => _deepGray;

  bool get darkModeOn => _darkModeOn;

}