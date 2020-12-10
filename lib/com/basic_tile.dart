import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// a basic tile widget
class BasicTile extends StatelessWidget {
  /// a basic tile widget constructor
  const BasicTile({
    Key? key,
    @required required this.child,
    this.color = Colors.white,
    this.splashColor = Colors.blue,
    this.onTap,
    this.edgeInsets = const EdgeInsets.all(10),
    this.elevation = 10.0,
    this.borderRadius = 15.0,
  }) : super(key: key);

  /// child widget of basic tile
  final Widget child;

  /// background color defaults to white
  final Color color;

  /// splash color defaults to blue
  final Color splashColor;

  /// callback function for tap events
  final Function? onTap;

  /// margin
  final EdgeInsets edgeInsets;

  /// elevation
  final double elevation;

  /// border radius
  final double borderRadius;

  @override
  Widget build(BuildContext context) => Container(
        margin: edgeInsets,
        child: Material(
          color: color,
          elevation: elevation,
          borderRadius: BorderRadius.circular(borderRadius),
          shadowColor: Theme.of(context).shadowColor,
          child: InkWell(
            splashColor: splashColor,
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: onTap == null ? () {} : () => onTap,
            child: child,
          ),
        ),
      );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(ColorProperty('splashColor', splashColor))
      ..add(DiagnosticsProperty<Function?>('onTap', onTap))
      ..add(DiagnosticsProperty<EdgeInsets>('edgeInsets', edgeInsets))
      ..add(DoubleProperty('elevation', elevation))
      ..add(DoubleProperty('borderRadius', borderRadius));
  }
}
