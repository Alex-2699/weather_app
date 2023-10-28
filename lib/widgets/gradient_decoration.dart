import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_app/providers/providers.dart';

class GradientDecoration extends ConsumerWidget {
  GradientDecoration({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref ) {
    final appTheme = ref.watch(appThemeProvider);
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [...appTheme.backgroundGradient],
        ),
      ),
    );
  }
  
}
