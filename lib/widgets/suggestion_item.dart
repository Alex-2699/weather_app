import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/providers/app_theme_provider.dart';

class SuggestionItem extends ConsumerWidget {

  final String description;
  final Function() onTap;

  const SuggestionItem({
    super.key, 
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeProv = ref.watch(appThemeProvider);

    return ListTile(
      leading: Icon(Icons.location_city_rounded, color: appThemeProv.gray),
      title: Text(description),
      onTap: () => onTap(),
    );
  }

}