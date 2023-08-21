import 'package:flutter/material.dart';

import 'package:weather_app/theme/app_theme.dart';

class GradientDecoration extends StatelessWidget {
  const GradientDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [...AppTheme.lightGradient],
        ),
      ),
    );
  }
}
