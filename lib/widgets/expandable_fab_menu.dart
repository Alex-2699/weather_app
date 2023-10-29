import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:weather_app/providers/providers.dart';
import 'package:weather_app/screens/screens.dart';
import 'package:weather_app/theme/app_theme.dart';

class FABMenu extends ConsumerWidget {
  const FABMenu({super.key});

  void _setLocationAsDefault(WidgetRef ref) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final location = ref.read(locationPropertiesProvider);
    final locationProperties = LocationProperties(placeId: location.placeId, placeName: location.placeName, isDefaultLocation: true);

    await prefs.setStringList('default_location', [location.placeId, location.placeName]);
    ref.read(locationPropertiesProvider.notifier).state = locationProperties;
  }

  void _navigateToSearchPlaces(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SearchLocation(closeScreen: true),
      ),
    );
  }

  void _closeOptions(GlobalKey<ExpandableFabState> key) {
    final state = key.currentState;
    if (state != null) state.toggle();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<ExpandableFabState>();

    final isDefaultLocation = ref.watch(locationPropertiesProvider).isDefaultLocation;
    final appThemeProv = ref.watch(appThemeProvider); 

    return ExpandableFab(
      key: key,
      openButtonBuilder: _rotateFABBuilder(appThemeProv, ExpandableFabSize.regular),
      closeButtonBuilder: _rotateFABBuilder(appThemeProv, ExpandableFabSize.small),
      overlayStyle: ExpandableFabOverlayStyle(blur: 1.2),
      duration: const Duration(milliseconds: 500),
      distance: 50.w,
      type: ExpandableFabType.side,
      children: [
        _FABSmall(
          icon: isDefaultLocation 
            ? Icons.star_rounded
            : Icons.star_border_rounded,
          onPressed: () => _setLocationAsDefault(ref),
        ),
        _FABSmall(
          icon: Icons.search_rounded,
          onPressed: () {
            _navigateToSearchPlaces(context);
            _closeOptions(key);
          } 
        ),
      ],
    );
  }

  RotateFloatingActionButtonBuilder _rotateFABBuilder(AppTheme appThemeProv, ExpandableFabSize fabSize) {
    return RotateFloatingActionButtonBuilder(
      child: const Icon(Icons.menu_rounded),
      fabSize: fabSize,
      foregroundColor: Colors.white,
      backgroundColor: appThemeProv.mountain2,
      shape: const CircleBorder(),
    );
  }

}

class _FABSmall extends ConsumerWidget {

  final IconData icon;
  final Function() onPressed;

  const _FABSmall({
    required this.onPressed, 
    required this.icon, 
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeProv = ref.watch(appThemeProvider); 

    return FloatingActionButton.small(
      heroTag: null,
      backgroundColor: appThemeProv.mountain2,
      child: Icon(icon, color: Colors.white),
      onPressed: () => onPressed(),
    );
  }

}