import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:weather_app/providers/providers.dart';
import 'package:weather_app/theme/app_theme.dart';

class EmptyOrErrorMessage extends ConsumerWidget {
  final bool isError;

  const EmptyOrErrorMessage({
    super.key, 
    required this.isError
  });

  Widget _buildDescriptionMessage(AppTheme appThemeProv) {
    String textMessage = isError
      ? 'Ocurrió un error inesperado, por favor intente mas tarde.'
      : 'No existen coincidencias.';

    return Text(textMessage, textAlign: TextAlign.center, style: appThemeProv.textNormalDark);
  } 

  Widget _buildMessageIcon(AppTheme appThemeProv) {
    IconData iconMessage = isError
      ? Icons.error_outline_rounded
      : Icons.travel_explore_rounded;

    return Icon(iconMessage, size: 60.h, color: appThemeProv.gray);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeProv = ref.watch(appThemeProvider);

    return Container(
      child: Column(
        children: [
          _buildMessageIcon(appThemeProv),
          SizedBox(height: 20.h),
          _buildDescriptionMessage(appThemeProv),
        ],
      ),
    );
  }


}
