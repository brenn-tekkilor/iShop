import 'package:flutter/material.dart';
import 'package:ishop/app/places/list/places_list_expandable_panel_animation_builder.dart';

class PlacesListExpandablePanelAnimation extends StatefulWidget {
  PlacesListExpandablePanelAnimation({required this.child});

  final Widget child;
  @override
  _PlacesListExpandablePanelAnimationState createState() =>
      _PlacesListExpandablePanelAnimationState();
}

class _PlacesListExpandablePanelAnimationState
    extends State<PlacesListExpandablePanelAnimation>
    with TickerProviderStateMixin {
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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final listWidth = size.width * 0.75;
    return PlacesListExpandablePanelAnimationBuilder(
      controller: _controller,
      beginValueX: 0.0,
      endValueX: listWidth - (listWidth - 250),
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
