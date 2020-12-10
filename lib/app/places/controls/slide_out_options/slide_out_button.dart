import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ishop/app/places/controls/slide_out_options/slide_out_option.dart';

/// SlideOutButton
class SlideOutButton extends SlideOutOption {
  /// SlideOutButton constructor
  const SlideOutButton(
      {Key? key,
      required Animation<double> controller,
      required Widget child,
      Animation<double> animation = kAlwaysCompleteAnimation})
      : super(
            key: key,
            animation: animation,
            child: child,
            controller: controller);

  @override
  Widget buildAnimation(BuildContext context, Widget? child) => Transform(
      transform: Matrix4.identity()..translate(animation.value), child: child);
}
