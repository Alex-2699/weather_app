import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:weather_app/providers/providers.dart';

class AppBarCustom extends ConsumerWidget implements PreferredSizeWidget{
  final String title;

  const AppBarCustom({
    super.key, 
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(appThemeProvider);

    return AppBar(
      title: Text(title, style: TextStyle(color: appTheme.deepGray)),
      backgroundColor: ThemeData.light().scaffoldBackgroundColor,
      leading:  const _CircleIcon(icon: Icons.location_on_rounded),
      leadingWidth: 100.w,
      actions: const [_CircleIcon(icon: Icons.close_rounded)],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}

class _CircleIcon extends ConsumerWidget {
  final IconData icon;

  const _CircleIcon({required this.icon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(appThemeProvider);
    
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(shape: BoxShape.circle, color: appTheme.mediumGray),
      child: Center(child: Icon(icon, size: 20, color: appTheme.deepGray)),
    );
  }

}