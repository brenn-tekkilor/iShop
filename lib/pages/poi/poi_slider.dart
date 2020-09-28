import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:frino_icons/frino_icons.dart';

class POISlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterSlider(
      jump: true,
      handler: FlutterSliderHandler(
        decoration: BoxDecoration(),
        child: Material(
          type: MaterialType.canvas,
          color: Colors.orange,
          elevation: 3,
          child: Container(
              padding: EdgeInsets.all(5),
              child: Icon(
                Icons.adjust,
                size: 25,
              )),
        ),
      ),
      handlerAnimation: FlutterSliderHandlerAnimation(
          curve: Curves.elasticOut,
          reverseCurve: Curves.bounceIn,
          duration: Duration(milliseconds: 500),
          scale: 1.5),
      trackBar: FlutterSliderTrackBar(
        activeTrackBarHeight: 12,
        centralWidget: Container(
          decoration: BoxDecoration(
              color: Colors.lightGreenAccent,
              borderRadius: BorderRadius.circular(50)),
          width: 9,
          height: 9,
        ),
        inactiveTrackBar: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black12,
          border: Border.all(width: 10, color: Colors.black),
        ),
        activeTrackBar: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.blueGrey.withOpacity(0.5)),
      ),
      tooltip: FlutterSliderTooltip(
        textStyle: TextStyle(fontSize: 17, color: Colors.white),
        boxStyle: FlutterSliderTooltipBox(
          decoration: BoxDecoration(color: Colors.redAccent.withOpacity(0.7)),
        ),
        leftPrefix: Icon(
          FrinoIcons.f_compass,
          size: 19,
          color: Colors.black45,
        ),
        rightSuffix: Text('km', style: Theme.of(context).textTheme.caption),
      ),
      values: [10],
      //#region fixedValues[]
      fixedValues: [
        FlutterSliderFixedValue(percent: 0, value: 2.0),
        FlutterSliderFixedValue(percent: 8, value: 4.0),
        FlutterSliderFixedValue(percent: 17, value: 8.0),
        FlutterSliderFixedValue(percent: 25, value: 12.0),
        FlutterSliderFixedValue(percent: 33, value: 16.0),
        FlutterSliderFixedValue(percent: 42, value: 20.0),
        FlutterSliderFixedValue(percent: 50, value: 24.0),
        FlutterSliderFixedValue(percent: 58, value: 32.0),
        FlutterSliderFixedValue(percent: 67, value: 40.0),
        FlutterSliderFixedValue(percent: 75, value: 48.0),
        FlutterSliderFixedValue(percent: 83, value: 56.0),
        FlutterSliderFixedValue(percent: 92, value: 64.0),
        FlutterSliderFixedValue(percent: 100, value: 128.0),
      ],
      //#endregion
      hatchMark: FlutterSliderHatchMark(
        density: 0.5, // means 50 lines, from 0 to 100 percent
        //#region labels
        labels: [
          FlutterSliderHatchMarkLabel(percent: 0, label: Text('2 km')),
          FlutterSliderHatchMarkLabel(percent: 25, label: Text('12')),
          FlutterSliderHatchMarkLabel(percent: 50, label: Text('24')),
          FlutterSliderHatchMarkLabel(percent: 75, label: Text('48')),
          FlutterSliderHatchMarkLabel(percent: 100, label: Text('128 km')),
        ],
        //#endregion
      ),
      //#region callbacks onDrag([Started|Dragging|Completed])
      onDragStarted: (handler, lower, upper) =>
          OnDragStarted(handler, lower, upper)..dispatch(context),
      onDragging: (handler, lower, upper) =>
          OnDragging(handler, lower, upper)..dispatch(context),
      onDragCompleted: (handler, lower, upper) =>
          OnDragCompleted(handler, lower, upper)..dispatch(context),
    );
  }
}

////#region Slider event Notification wrappers
////#region description and example
//// Wrappers for sending Slider Drag event Notifications
////  to parent NotificationListener Ancestors.
//// -----------------
//// example:
////   A (a) NotificationListener Widget Ancestor
////    and a descendant (b) Slider (c) event callback
////    that creates, populates, and dispatches a
////    Notification inheriting subclass.
////
////
//// a) NotificationListener<OnDragStarted>(
////      child: <Widget>
////        ....
////        Slider(
////          ....
////          onDragStarted: (handler, lower, upper) {
////            OnDragStarted(handler, lower, upper)
////            ..dispatch(context);
////          },
////          ....
////        ),
////#endregion
class OnDragStarted extends Notification {
  const OnDragStarted(this.handlerIndex, this.lowerValue, this.upperValue);
  final int handlerIndex;
  final dynamic lowerValue;
  final dynamic upperValue;
}

class OnDragging extends Notification {
  const OnDragging(this.handlerIndex, this.lowerValue, this.upperValue);
  final int handlerIndex;
  final dynamic lowerValue;
  final dynamic upperValue;
}

class OnDragCompleted extends Notification {
  const OnDragCompleted(this.handlerIndex, this.lowerValue, this.upperValue);
  final int handlerIndex;
  final dynamic lowerValue;
  final dynamic upperValue;
}
////#endregion
