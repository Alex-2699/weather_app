import 'package:flutter/material.dart';

class SuggestionItem extends StatelessWidget {

  final String description;
  final Function() onTap;

  const SuggestionItem({
    super.key, 
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.location_city_rounded),
      title: Text(description),
      onTap: () => onTap(),
    );
  }

}