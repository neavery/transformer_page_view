import 'dart:math';
import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class ZoomOutPageTransformer extends PageTransformer {
  static const double minScale = 0.85;
  static const double minAlpha = 0.5;

  @override
  Widget transform(Widget? child, TransformInfo info) {
    double position = info.position!;
    double pageWidth = info.width!;
    double pageHeight = info.height!;

    if (position < -1) {
      return Opacity(
        opacity: 0.0,
        child: child,
      );
    } else if (position <= 1) {
      double scaleFactor = max(minScale, 1 - position.abs());
      double vertMargin = pageHeight * (1 - scaleFactor) / 2;
      double horzMargin = pageWidth * (1 - scaleFactor) / 2;
      double alpha = minAlpha + (scaleFactor - minScale) /
          (1 - minScale) * (1 - minAlpha);

      return Opacity(
        opacity: alpha,
        child: Transform.translate(
          offset: position < 0
              ? Offset(horzMargin - vertMargin / 2, 0)
              : Offset(-horzMargin + vertMargin / 2, 0),
          child: Transform.scale(
            scale: scaleFactor,
            child: child,
          ),
        ),
      );
    } else {
      return Opacity(
        opacity: 0.0,
        child: child,
      );
    }
  }
}
