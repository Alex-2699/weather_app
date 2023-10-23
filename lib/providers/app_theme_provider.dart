import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/theme/app_theme.dart';

final appThemeProvider = StateProvider<AppTheme>((ref) {
  return AppTheme();
});