import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/theme/app_theme.dart';

class Mountains extends CustomPainter {
  final AppTheme appTheme;

  Mountains(this.appTheme);

  @override
  void paint(Canvas canvas, Size size) {

    final Paint paintM1 = Paint()
      ..color = appTheme.mountain1
      ..style = PaintingStyle.fill;

    final Path pathM1 = Path()
      ..moveTo(- (size.height + 90.h), size.height) // Punto inferior izquierdo
      ..lineTo(size.width * 0.15.h, 0.w) // Punto superior
      ..lineTo(size.width * 1.60.h, size.height) // Punto inferior derecho
      ..close();

    final Paint paintM2 = Paint()
      ..color = appTheme.mountain2
      ..style = PaintingStyle.fill;

    final Path pathM2 = Path()
      ..moveTo(- size.height, size.height) // Punto inferior izquierdo
      ..lineTo(size.width / 2, 30.w) // Punto superior
      ..lineTo(size.width * 2.h, size.height) // Punto inferior derecho
      ..close();

    final Paint paintM3 = Paint()
      ..color = appTheme.mountain3
      ..style = PaintingStyle.fill;

    final Path pathM3 = Path()
      ..moveTo(- size.height + 200.h, size.height) // Punto inferior izquierdo
      ..lineTo(size.width, 90.h) // Punto superior
      ..lineTo(size.width * 2.h, size.height) // Punto inferior derecho
      ..close();

    final Paint paintM4 = Paint()
      ..color = appTheme.mountain4
      ..style = PaintingStyle.fill;

    final Path pathM4 = Path()
      ..moveTo(0.h, size.height) // Punto inferior izquierdo
      ..lineTo(size.width * 0.6.h, 200.w) // Punto superior
      ..lineTo(size.width * 1.40.h, size.height) // Punto inferior derecho
      ..close();

    final Paint paintM5 = Paint()
      ..color = appTheme.mountain5
      ..style = PaintingStyle.fill;

    final Path pathM5 = Path()
      ..moveTo(0.h, size.height) // Punto inferior izquierdo
      ..lineTo(0.h, 170.w) // Punto superior
      ..lineTo(size.width.h, size.height) // Punto inferior derecho
      ..close();

    canvas.drawPath(pathM1, paintM1);
    canvas.drawPath(pathM2, paintM2);
    canvas.drawPath(pathM3, paintM3);
    canvas.drawPath(pathM4, paintM4);
    canvas.drawPath(pathM5, paintM5);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
  
}

class MountainBackground extends StatelessWidget {
  const MountainBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context);

    double sunPosition = appTheme.darkModeOn ? 50 : 300;
    double moonPosition = appTheme.darkModeOn ? 300 : 50;

    return Stack(
      children: [
        _SunOrMoonIcon(sunPosition: sunPosition, appTheme: appTheme),
        _SunOrMoonIcon(sunPosition: moonPosition, appTheme: appTheme),
        SizedBox(
          width: double.infinity,
          height: 300.h,
          child: ClipRRect(
            child: CustomPaint(
              painter: Mountains(appTheme),
            ),
          ),
        ),
      ],
    );
  }
  
}

class _SunOrMoonIcon extends StatelessWidget {

  final double sunPosition;
  final AppTheme appTheme;

  const _SunOrMoonIcon({
    required this.sunPosition,
    required this.appTheme,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      right: 20.w,
      bottom: sunPosition,
      child: Icon(Icons.circle, size: 40.h, color: appTheme.mountain1),
    );
  }

}
