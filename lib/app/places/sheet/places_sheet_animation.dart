import 'package:flutter/material.dart';
import 'package:ishop/app/places/sheet/places_sheet_animation_builder.dart';
import 'package:ishop/data/service/places_api.dart';

class PlacesSheetAnimation extends StatefulWidget {
  PlacesSheetAnimation({required Widget child}) : _child = child;
  final Widget _child;
  Widget get child => _child;
  @override
  _PlacesSheetAnimationState createState() => _PlacesSheetAnimationState();
}

class _PlacesSheetAnimationState extends State<PlacesSheetAnimation>
    with TickerProviderStateMixin {
  final _api = PlacesAPI.instance();
  late final AnimationController _controller;
  void _open() {
    _controller.forward(from: _controller.value);
  }

  void _close() {
    _controller.reverse(from: _controller.value);
  }

  void _toggle() {
    if (!_controller.isAnimating) {
      _controller.isCompleted ? _close() : _open();
    }
  }

  void _onAnimationStatusChange(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _api.isSheetVisible = _controller.value > 0.9;
    }
    if (status == AnimationStatus.reverse) {
      _api.isSheetVisible = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _controller.addStatusListener((status) => _onAnimationStatusChange(status));
  }

  @override
  void dispose() {
    _controller
        .removeStatusListener((status) => _onAnimationStatusChange(status));
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sheetWidth = size.width * 0.75;
    return PlacesSheetAnimationBuilder(
      controller: _controller,
      beginValueX: 0.0,
      endValueX: sheetWidth - (sheetWidth - 250),
      beginIntervalX: 0.0,
      endIntervalX: 0.4,
      beginValueY: 0.0,
      endValueY: -255.0,
      beginIntervalY: 0.6,
      endIntervalY: 1.0,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _toggle,
        child: widget.child,
      ),
    );
  }
}
