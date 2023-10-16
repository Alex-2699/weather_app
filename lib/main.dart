import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_app/screens/screens.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
} 

// class AppState extends StatelessWidget {
//   const AppState({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => AppTheme()),
//         ChangeNotifierProvider(create: (_) => WeatherProvider()),
//         ChangeNotifierProvider(create: (_) => LocationSearchProvider()),
//         ChangeNotifierProvider(create: (_) => WeatherForecastProvider()),
//       ],
//       child: const MyApp(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Clima',
          home: child,
        );
      },
      child: const SearchLocation(),
      // child: const HomeScreen(latitude: 18.1074, longitude:  -96.1457, locationName: 'Tuxtepec'),
    );
  }
}