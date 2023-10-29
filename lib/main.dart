import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_app/models/location_coordinates/location.dart';
import 'package:weather_app/providers/providers.dart';
import 'package:weather_app/screens/screens.dart';
import 'package:weather_app/theme/app_theme.dart';
import 'package:weather_app/utils/utils.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
} 

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  Widget _getDefaultLocationInPreferences(WidgetRef ref) {
    final defaultLocationProv = ref.watch(getDefaultLocationProvider);

    return RequestStateEvaluator(
      dataProvider: defaultLocationProv,
      onDataHasLoaded: (data) {
        if (data == null) return const SearchLocation();
        
        return _navigateToHomeScreen(ref, defaultLocationProv);
      },
    ).evaluateRequest(Container());
  }

  FutureBuilder<Location> _navigateToHomeScreen(WidgetRef ref, AsyncValue<List<String>?> defaultLocationProv) {
    final placeId = defaultLocationProv.asData!.value![0];
    final placeName = defaultLocationProv.asData!.value![1];

    return FutureBuilder(
      future: ref.read(getPlaceCordinatesProvider(placeId).future),
      builder: (context, snapshot) {
        if (snapshot.hasData) return HomeScreen(locationName: placeName);
        
        return Container(color: Colors.amber);
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