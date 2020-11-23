import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation.dart';
import 'package:ishop/com/custom_staggered_animation.dart';

class PlacesListExpandablePanelAnimationBuilder
    extends CustomStaggeredAnimation {
  PlacesListExpandablePanelAnimationBuilder(
      {Key? key,
      required AnimationController controller,
      required double beginValueX,
      required double endValueX,
      required double beginIntervalX,
      required double endIntervalX,
      required double beginValueY,
      required double endValueY,
      required double beginIntervalY,
      required double endIntervalY,
      Widget child = _defaultChild})
      : _controller = controller,
        _slideOut = Tween<double>(begin: beginValueX, end: endValueX)
            .animate(CurvedAnimation(
          parent: controller,
          curve: Interval(
            beginIntervalX,
            endIntervalX,
            curve: Curves.ease,
          ),
        )),
        _slideUp = Tween<double>(begin: beginValueY, end: endValueY)
            .animate(CurvedAnimation(
          parent: controller,
          curve: Interval(
            beginIntervalY,
            endIntervalY,
            curve: Curves.ease,
          ),
        )),
        _child = child,
        super(key: key);

  final AnimationController _controller;
  final Animation<double> _slideOut;
  final Animation<double> _slideUp;
  final Widget _child;

  @override
  AnimationController get controller => _controller;

  // This function is called each time the controller "ticks" a new frame.
  // When it runs, all of the animation's values will have been
  // updated to reflect the controller's current value.
  Widget _buildAnimation(BuildContext context, _) => Transform(
      transform: Matrix4.identity()..translate(_slideOut.value, _slideUp.value),
      child: _child);
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: _controller,
    );
  }

  static const _defaultChild = Placeholder(
    color: Colors.black,
    strokeWidth: 4.0,
    fallbackHeight: 50,
    fallbackWidth: 300,
  );
}
