import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomProgressIndicator {

  static Widget staggeredDotsWave() {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Colors.white,
        size: 30.h,
      ),
    );
  }

  static Widget staggeredDotsWaveDark() {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Colors.blueGrey,
        size: 30.h,
      ),
    );
  }

}