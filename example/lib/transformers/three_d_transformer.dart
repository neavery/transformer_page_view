import 'dart:math';

import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:vector_math/vector_math_64.dart';

class ThreeDTransformer extends PageTransformer {
  @override
  Widget transform(Widget? child, TransformInfo info) {
    double position = info.position;

    double rotationY = position * 45 * pi / 180;
    double scale = 1.0 - (position.abs() * 0.15);

    Matrix4 transform = Matrix4.identity()
      ..setEntry(3, 2, 0.005) // perspective
      ..translateByVector3(Vector3(0.0, 0.0, position * -50))
      ..rotateY(rotationY)
      ..scaleByVector3(Vector3(scale, scale, 1.0));

    return Transform(
      transform: transform,
      alignment: Alignment.center,
      child: child,
    );
  }
}
