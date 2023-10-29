import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:weather_app/providers/providers.dart';

class AppBarCustom extends ConsumerWidget implements PreferredSizeWidget{
  
  final String title;
  final bool closeScreen;

  const AppBarCustom({
    super.key, 
    required this.title,
    this.closeScreen = false, 
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(appThemeProvider);

    return AppBar(
      title: Text(title, style: TextStyle(color: appTheme.deepGray)),
      backgroundColor: ThemeData.light().scaffoldBackgroundColor,
      leading: const _CircleIcon(icon: Icons.location_on_rounded),
      leadingWidth: 100.w,
      actions: [
        if(closeScreen)
          _CircleIcon(icon: Icons.close_rounded, onPressed: () => Navigator.pop(context)) 
      ],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}

class _CircleIcon extends ConsumerWidget {

  final IconData icon;
  final Function()? onPressed; 

  const _CircleIcon({
    required this.icon, 
    this.onPressed
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(appThemeProvider);
    
    return GestureDetector(
      onTap: onPressed == null ? null : () => onPressed!(),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(shape: BoxShape.circle, color: appTheme.mediumGray),
        child: Center(child: Icon(icon, size: 20, color: appTheme.deepGray)),
      ),
    );
  }

}