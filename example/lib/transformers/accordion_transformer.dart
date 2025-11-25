import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class AccordionTransformer extends PageTransformer {
  @override
  Widget transform(Widget? child, TransformInfo info) {
    double position = info.position!;

    if (position < 0.0) {
      return Transform.scale(
        scale: 1 + position,
        alignment: Alignment.topRight,
        child: child,
      );
    } else {
      return Transform.scale(
        scale: 1 - position,
        alignment: Alignment.bottomLeft,
        child: child,
      );
    }
  }
}
