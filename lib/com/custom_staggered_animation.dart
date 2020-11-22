import 'package:flutter/material.dart';

abstract class CustomStaggeredAnimation extends StatelessWidget {
  const CustomStaggeredAnimation({Key? key}) : super(key: key);

  AnimationController get controller;
  // This function is called each time the controller "ticks" a new frame.
  // When it runs, all of the animation's values will have been
  // updated to reflect the controller's current value.

  @override
  Widget build(BuildContext context);
}
