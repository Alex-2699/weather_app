import 'package:flutter/material.dart';
import 'package:weather_app/theme/app_theme.dart';

class InputText extends StatelessWidget {

  final IconData? prefixIcon;
  final Function(String value) onChange;

  const InputText({
    super.key, 
    this.prefixIcon, 
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    BorderSide borderSide = BorderSide(color: AppTheme().lightGray);
    BorderRadius borderRadius = BorderRadius.circular(10);

    return TextField(
      cursorColor: AppTheme().darkGray,
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
          color: AppTheme().darkGray,
        ),
        hintText: 'Ciudad',
        filled: true,
        fillColor: AppTheme().lightGray
      ),
      onChanged: (value) => onChange(value),
    );
  }

}