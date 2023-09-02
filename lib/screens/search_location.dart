import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weather_app/providers/providers.dart';

class SearchLocation extends StatelessWidget {
  const SearchLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<LocationSearchProvider>(context,);

    return Scaffold(
      appBar: AppBar(
        title: Text('Búsqueda en Flutter con Provider'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) => searchProvider.getPlaceSuggestions(value),
              decoration: InputDecoration(
                labelText: 'Buscar',
                hintText: 'Ingrese su búsqueda',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchProvider.suggestions.predictions.length,
              itemBuilder: (_, i) {
                return ListTile(
                  title: Text(searchProvider.suggestions.predictions[i].description),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
