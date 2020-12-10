import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// CustomStaggeredAnimation
abstract class CustomStaggeredAnimation extends StatelessWidget {
  /// CustomStaggeredAnimation constructor
  const CustomStaggeredAnimation({Key? key}) : super(key: key);

  /// controller
  Animation<double> get controller;
  // This function is called each time the controller "ticks" a new frame.
  // When it runs, all of the animation's values will have been
  // updated to reflect the controller's current value.

  @override
  Widget build(BuildContext context);
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<Animation<double>>('controller', controller));
  }
}
