import 'package:flutter/material.dart';

class CurvedRectArcTween extends MaterialRectArcTween {
  CurvedRectArcTween({
    super.begin,
    super.end,
  });
  @override
  Rect lerp(double t) {
    Cubic easeInOut = const Cubic(0.42, 0.0, 0.58, 1.0);
    double curvedT = easeInOut.transform(t);
    return super.lerp(curvedT);
  }
}
