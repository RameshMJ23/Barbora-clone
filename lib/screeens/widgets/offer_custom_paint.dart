import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(0,0);
    path_0.lineTo(size.width,0);
    path_0.lineTo(size.width,size.height*0.7744111);
    path_0.lineTo(size.width*0.5000000,size.height*0.9259259);
    path_0.lineTo(0,size.height*0.7744111);
    path_0.lineTo(0,0);
    path_0.close();

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = Color(0xffFAF00C).withOpacity(1.0);
    canvas.drawPath(path_0,paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(0,size.height*0.7592593);
    path_1.lineTo(size.width*0.5000000,size.height*0.9074074);
    path_1.lineTo(size.width,size.height*0.7592593);
    path_1.lineTo(size.width,size.height*0.8392259);
    path_1.lineTo(size.width*0.5000000,size.height*0.9907407);
    path_1.lineTo(0,size.height*0.8392259);
    path_1.lineTo(0,size.height*0.7592593);
    path_1.close();

    Paint paint_1_fill = Paint()..style=PaintingStyle.fill;
    paint_1_fill.color = Color(0xffFFD057).withOpacity(1.0);
    canvas.drawPath(path_1,paint_1_fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}