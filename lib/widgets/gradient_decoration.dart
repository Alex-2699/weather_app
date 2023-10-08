import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather_app/theme/app_theme.dart';

class GradientDecoration extends StatelessWidget {
  const GradientDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context);
    
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
