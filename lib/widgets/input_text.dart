import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_app/providers/providers.dart';

class InputText extends ConsumerWidget {

  final IconData? prefixIcon;
  final Function(String value) onChange;

  const InputText({
    super.key, 
    this.prefixIcon, 
    required this.onChange,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(appThemeProvider);

    BorderSide borderSide = BorderSide(color: appTheme.lightGray);
    BorderRadius borderRadius = BorderRadius.circular(10);

    return TextField(
      cursorColor: appTheme.darkGray,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: borderSide, 
          borderRadius: borderRadius,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: borderSide,
          borderRadius: borderRadius,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: appTheme.darkGray,
        ),
        hintText: 'Ciudad',
        filled: true,
        fillColor: appTheme.lightGray
      ),
      onChanged: (value) => onChange(value),
    );
  }

}