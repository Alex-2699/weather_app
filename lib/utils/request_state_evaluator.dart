import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestStateEvaluator {

  final AsyncValue<dynamic> dataProvider;
  final Function(dynamic) onDataHasLoaded; 

  RequestStateEvaluator({
    required this.dataProvider,
    required this.onDataHasLoaded,
  });
  
  Widget evaluateRequest(Widget progressIndicator) {
    return dataProvider.when(
      data: (data) => onDataHasLoaded(data), 
      error: (error, stackTrace) => Text('Error: $error'), 
      loading: () => progressIndicator,
    );
  }

}