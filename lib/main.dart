import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/date_symbol_data_local.dart';

import 'package:weather_app/providers/providers.dart';
import 'package:weather_app/screens/screens.dart';
import 'package:weather_app/theme/app_theme.dart';
import 'package:weather_app/widgets/resources/error_screen.dart';


void main() async { 
  await dotenv.load(fileName: ".env");

  initializeDateFormatting('es').then((_) {
    runApp(
      const ProviderScope(child: MyApp()),
    );
  });

} 

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  Widget _getDefaultLocationInPreferences(WidgetRef ref) {
    final defaultLocationProv = ref.watch(getDefaultLocationProvider);

    return defaultLocationProv.when(
      data: (data) {
        if (data == null) return const SearchLocation();

        return _navigateToCurrentWeatherScreen(ref, defaultLocationProv);
      },
      error: (error, stackTrace) => const CurrentWeatherScreen(),
      loading: () => const CircularProgressIndicator(),
    );
  }

  Widget _navigateToCurrentWeatherScreen(WidgetRef ref, AsyncValue<List<String>?> defaultLocationProv) {
    final placeId = defaultLocationProv.asData!.value![0];
    final placeName = defaultLocationProv.asData!.value![1];

    final locationProperties = LocationProperties(placeId: placeId, placeName: placeName, isDefaultLocation: true);
    Future<void>.microtask(() {
      ref.read(locationPropertiesProvider.notifier).state = locationProperties;
    });

    return Consumer(
      builder: (context, ref, child) {
        final placeCoordinatesState = ref.watch(getPlaceCordinatesProviderLogin(placeId));

        return placeCoordinatesState.when(
          data: (data) => const CurrentWeatherScreen(),
          loading: () => Container(color: Colors.amber),
          error: (error, stackTrace) => const ErrorScreen(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Clima',
          home: child,
          theme: AppTheme().globalTheme,
        );
      },
      child: _getDefaultLocationInPreferences(ref),
    );
  }
  
}