import 'package:flutter/material.dart';

class SuggestionItem extends StatelessWidget {
  final String description;

  const SuggestionItem({
    super.key, 
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.location_city_rounded),
      title: Text(description),
    );
  }

}