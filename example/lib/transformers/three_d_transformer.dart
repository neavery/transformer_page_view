import 'dart:math';
import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class ThreeDTransformer extends PageTransformer {
  @override
  Widget transform(Widget? child, TransformInfo info) {
    double position = info.position!;
    double width = info.width!;

    double rotationY = position * -30;

    Matrix4 transform = Matrix4.identity();
    transform.setEntry(3, 2, 0.001);

    if (position < 0) {
      transform.rotateY(rotationY * pi / 180);
      transform.translateByDouble(position * width, 0, 0, 0);
    } else {
      transform.translateByDouble(-position * width, 0, 0, 0);
      transform.rotateY(rotationY * pi / 180);
    }

    return Transform(
      transform: transform,
      alignment: Alignment.center,
      child: child,
    );
  }
}
