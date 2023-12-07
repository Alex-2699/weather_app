import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:weather_app/providers/providers.dart';

class ErrorScreen extends StatelessWidget {
  final bool closeScreen;

  const ErrorScreen({
    super.key, 
    this.closeScreen = false
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Opacity(
              opacity: 0.9,
              child: Image.asset('assets/cloud_warning.png', height: 150.h),
            ),
            SizedBox(height: 30.h),
            _TextMessages(closeScreen: closeScreen),
          ],
        ),
      )
    );
  }

}

class _TextMessages extends ConsumerWidget {
  final bool closeScreen;

  const _TextMessages({required this.closeScreen});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeProv = ref.watch(appThemeProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Oh no!', style: appThemeProv.textTitleError),
        SizedBox(height: 10.h),
        Text('Algo salió mal. Por favor, vuelva a intentarlo.', style: appThemeProv.textSubtitleError),
        SizedBox(height: 30.h),
        _RetryButton(closeScreen: closeScreen)
      ],
    );
  }

}

class _RetryButton extends ConsumerWidget {
  final bool closeScreen;

  const _RetryButton({required this.closeScreen});

  void _onPressed(BuildContext context, WidgetRef ref) async {
    if(closeScreen) {
      Navigator.pop(context);
    } else {
      final locationPropertiesProv = ref.read(locationPropertiesProvider.notifier).update((state) => state);
      await ref.refresh(getPlaceCordinatesProvider(locationPropertiesProv.placeId).future);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeProv = ref.watch(appThemeProvider);

    return SizedBox(
      height: 36.h,
      width: 110.w,
      child: ElevatedButton(
        onPressed: () => _onPressed(context, ref),
        child: Text('Reintentar', style: appThemeProv.textTitleButton),
      ),
    );
  }
}
