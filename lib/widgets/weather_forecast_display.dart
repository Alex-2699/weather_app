import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherForecastDisplay extends StatelessWidget {
  const WeatherForecastDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Hoy'),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.h),
            width: double.infinity,
            height: 120.h,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.16),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) => _ForecastItem(), 
                separatorBuilder: (context, index) => SizedBox(width: 10,),
              ),
            )
          ),
        ],
      ),
    );
  }
}

class _ForecastItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      //color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('2 PM'),
          Icon(Icons.cloud_rounded),
          Text('10°')
        ],
      ),
    );
  }
}