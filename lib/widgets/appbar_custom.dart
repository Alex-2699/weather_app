import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/theme/app_theme.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget{
  final String title;

  const AppBarCustom({
    super.key, 
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    //final appTheme = Provider.of<AppTheme>(context);

    return AppBar(
      title: Text(title, style: TextStyle(color: AppTheme().deepGray)),
      backgroundColor: ThemeData.light().scaffoldBackgroundColor,
      leading:  const _CircleIcon(icon: Icons.location_on_rounded),
      leadingWidth: 100.w,
      actions: const [_CircleIcon(icon: Icons.close_rounded)],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}

class _CircleIcon extends StatelessWidget {
  final IconData icon;

  const _CircleIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    //final appTheme = Provider.of<AppTheme>(context);
    
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme().mediumGray),
      child: Center(child: Icon(icon, size: 20, color: AppTheme().deepGray)),
    );
  }
}