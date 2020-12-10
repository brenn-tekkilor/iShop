import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Open
class SlideOutOption extends StatelessWidget {
  /// Open constructor
  const SlideOutOption({
    Key? key,
    required Animation<double> controller,
    required Widget child,
    Animation<double> animation = kAlwaysCompleteAnimation,
  })  : _animation = animation,
        _controller = controller,
        _child = child,
        super(key: key);

  /// animation
  final Animation<double> _animation;

  /// controller
  final Animation<double> _controller;

  /// child
  final Widget _child;

  /// animation
  Animation<double> get animation => _animation;

  /// controller
  Animation<double> get controller => _controller;

  /// child
  Widget get child => _child;

  /// buildAnimation
  Widget buildAnimation(BuildContext context, Widget? child) => Transform(
        transform: Matrix4.identity()..scaleAdjoint(animation.value),
        child: child,
      );

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        builder: buildAnimation,
        animation: controller,
        child: child,
      );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Animation<double>>('animation', animation))
      ..add(DiagnosticsProperty<Animation<double>>('controller', controller));
  }
}
