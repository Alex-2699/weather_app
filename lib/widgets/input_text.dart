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
    final appThemeProv = ref.watch(appThemeProvider);

    BorderSide borderSide = BorderSide(color: appThemeProv.lightGray);
    BorderRadius borderRadius = BorderRadius.circular(10);

    return TextField(
      cursorColor: appThemeProv.darkGray,
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
          color: appThemeProv.darkGray,
        ),
        hintText: 'Ciudad',
        filled: true,
        fillColor: appThemeProv.lightGray
      ),
      onChanged: (value) => onChange(value),
    );
  }

}