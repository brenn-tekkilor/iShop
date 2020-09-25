import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ishop/utils/text_styles.dart';
import 'package:ishop/utils/ui_helpers.dart';
import 'package:ishop/widgets/basic_tile.dart';

class BottomDrawer extends StatefulWidget {
  @override
  _BottomDrawerState createState() => _BottomDrawerState();
}

class _BottomDrawerState extends State<BottomDrawer>
    with SingleTickerProviderStateMixin {
  //#region immutable layout properties

  final double minHeight = 80;

  final double iconStartSize = 75;

  final double iconEndSize = 110;

  final double iconStartMarginTop = -15;

  final double iconEndMarginTop = 50;

  final double iconsVerticalSpacing = 0;

  final double iconsHorizontalSpacing = 0;

  //#region final List<SheetItem> items
  final List<SheetItem> items = [
    SheetItem('assets/icon/icon-legacy.png', 'Icon 1'),
    SheetItem('assets/icon/icon-legacy.png', 'Icon 2'),
    SheetItem('assets/icon/icon-legacy.png', 'Icon 3'),
    SheetItem('assets/icon/icon-legacy.png', 'Icon 4'),
  ];
  //#endregion

  //#endregion

  //#region context layout properties

  double get maxHeight => MediaQuery.of(context).size.height;

  double get headerTopMargin =>
      lerp(16, 0 + MediaQuery.of(context).padding.top);

  //#endregion

  //#region bottom sheet status/control
  bool get isBottomSheetOpen =>
      (controller.status == AnimationStatus.completed);

  AnimationController controller;

  void toggleBottomSheet() =>
      controller.fling(velocity: isBottomSheetOpen ? -2 : 2);

  //#endregion

  //#region dynamic layout values
  double get itemBorderRadius => lerp(8, 15);

  double get iconLeftBorderRadius => itemBorderRadius;

  double get iconRightBorderRadius => itemBorderRadius;

  double get iconSize => lerp(iconStartSize, iconEndSize);

  double iconTopMargin(int index) =>
      lerp(
        iconStartMarginTop,
        iconEndMarginTop + index * (iconsVerticalSpacing + iconEndSize),
      ) +
      headerTopMargin;

  double iconLeftMargin(int index) =>
      lerp(index * (iconsHorizontalSpacing + iconStartSize), 0);
  double lerp(double min, double max) => lerpDouble(min, max, controller.value);

  //#endregion

  //#region Widget builders

  Widget _buildIcon(SheetItem item) {
    var index = items.indexOf(item);
    return Positioned(
      height: iconSize,
      width: iconSize,
      top: iconTopMargin(index),
      left: iconLeftMargin(index),
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          child: Image.asset(
            'assets/icon/icon-legacy.png',
            fit: BoxFit.cover,
            alignment: Alignment(lerp(0, 0), 0),
          ),
        ),
      ),
    );
  }

  Widget _buildFullItem(SheetItem item) {
    var index = items.indexOf(item);
    return ExpandedSheetItem(
      topMargin: iconTopMargin(index),
      leftMargin: iconLeftMargin(index),
      height: iconSize,
      isVisible: controller.status == AnimationStatus.completed,
      borderRadius: itemBorderRadius,
      title: item.title,
    );
  }

  Widget _buildMenuButton() {
    return Positioned(
      right: 0,
      bottom: 30,
      child: GestureDetector(
        onTap: toggleBottomSheet,
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          size: 24.0,
          progress: controller,
          semanticLabel: 'Open/close',
          color: invertColorsMild(context),
        ),
      ),
    );
  }

  //#endregion

  //#region drag handlers

  void _handleDragUpdate(DragUpdateDetails details) {
    controller.value -= details.primaryDelta / maxHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (controller.isAnimating ||
        controller.status == AnimationStatus.completed) return;

    final flingVelocity = details.velocity.pixelsPerSecond.dy / maxHeight;
    if (flingVelocity < 0.0) {
      controller.fling(
        velocity: math.max(2.0, -flingVelocity),
      );
    } else if (flingVelocity > 0.0) {
      controller.fling(
        velocity: math.min(-2.0, -flingVelocity),
      );
    } else {
      controller.fling(velocity: controller.value < 0.5 ? -2.0 : 2.0);
    }
  }

//#endregion

  //#region overrides

  //#region init/dispose (AnimationController)

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  //#endregion

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Positioned(
          height: lerp(minHeight, maxHeight),
          left: 0,
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: toggleBottomSheet,
            onVerticalDragUpdate: _handleDragUpdate,
            onVerticalDragEnd: _handleDragEnd,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: shadowColor(context),
                    blurRadius: 15.0,
                  ),
                ],
              ),
              child: Material(
                color: invertInvertColorsMild(context),
                elevation: 10.0,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                shadowColor: shadowColor(context),
                child: InkWell(
                  onTap: doNothing,
                  splashColor: invertColorsMaterial(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Stack(
                      children: <Widget>[
                        _buildMenuButton(),
                        for (SheetItem item in items) _buildFullItem(item),
                        for (SheetItem item in items) _buildIcon(item),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  //#endregion

}

class ExpandedSheetItem extends StatelessWidget {
  const ExpandedSheetItem(
      {Key key,
      this.topMargin,
      this.height,
      this.isVisible,
      this.borderRadius,
      this.title,
      this.leftMargin})
      : super(key: key);

  final double topMargin;
  final double leftMargin;
  final double height;
  final bool isVisible;
  final double borderRadius;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topMargin,
      left: leftMargin,
      right: 0,
      height: height,
      child: AnimatedOpacity(
        opacity: isVisible ? 1 : 0,
        duration: Duration(milliseconds: 200),
        child: BasicTile(
          color: invertColorsMaterial(context),
          splashColor: invertInvertColorsMaterial(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: 100.0,
                ),
                child: Text(
                  'Press & hold me',
                  style: isThemeCurrentlyDark(context)
                      ? SubHeadingStylesMaterial.light
                      : SubHeadingStylesMaterial.dark,
                ),
              ),
            ],
          ),
          onTap: doNothing,
        ),
      ),
    );
  }

  Widget buildContent() {
    return Column(
      children: <Widget>[
        Text(
          'Fix me $title',
        ),
      ],
    );
  }
}

class SheetItem {
  SheetItem(this.assetName, this.title);

  final String assetName;
  final String title;
}

class SheetHeader extends StatelessWidget {
  const SheetHeader(
      {Key key, @required this.fontSize, @required this.topMargin})
      : super(key: key);

  final double fontSize;
  final double topMargin;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 0,
        top: 0,
        height: 30,
        child: Expanded(child: Text('Sheet Header')));
  }
}
