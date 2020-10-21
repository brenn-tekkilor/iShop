import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:ishop/pages/poi/poi_state.dart';

class POISlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _POISliderState();
}

class _POISliderState extends State<POISlider> {
  final GlobalKey sliderKey = GlobalKey();
  POIState _data;

  double _value;

  void _onSlide(dynamic value) {
    if (value != null &&
        value is double &&
        value >= 2.0 &&
        value != _data.radius) {
      _value = _data.radius = value;
    }
  }

  @override
  Widget build(BuildContext context) {
    _data ??= POIStateContainer.of(context).state;
    _value ??= _data.radius;

    return FlutterSlider(
      key: sliderKey,
      axis: Axis.horizontal,
      jump: true,
      handler: FlutterSliderHandler(
        child: Material(
          type: MaterialType.circle,
          color: Colors.cyan,
          elevation: 100,
          child: Container(
              padding: EdgeInsets.all(5),
              child: Icon(
                Icons.add_location_outlined,
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
              borderRadius: BorderRadius.circular(5)),
          width: 5,
          height: 10,
        ),
        inactiveTrackBar: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Colors.cyan,
          border: Border.all(width: 10, color: Colors.black),
        ),
        activeTrackBar: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.blueGrey.withOpacity(0.5)),
      ),
      tooltip: FlutterSliderTooltip(
        textStyle: TextStyle(fontSize: 17, color: Colors.white),
        boxStyle: FlutterSliderTooltipBox(
          decoration:
              BoxDecoration(color: Colors.orangeAccent.withOpacity(0.7)),
        ),
        leftPrefix: Icon(
          FrinoIcons.f_compass,
          size: 19,
          color: Colors.black45,
        ),
        rightSuffix: Text('km', style: Theme.of(context).textTheme.caption),
      ),
      values: [_value],

      //#region fixedValues[]
      fixedValues: [
        FlutterSliderFixedValue(percent: 0, value: 2.0),
        FlutterSliderFixedValue(percent: 5, value: 3.0),
        FlutterSliderFixedValue(percent: 10, value: 4.0),
        FlutterSliderFixedValue(percent: 15, value: 5.0),
        FlutterSliderFixedValue(percent: 20, value: 6.0),
        FlutterSliderFixedValue(percent: 25, value: 7.0),
        FlutterSliderFixedValue(percent: 30, value: 8.0),
        FlutterSliderFixedValue(percent: 35, value: 9.0),
        FlutterSliderFixedValue(percent: 40, value: 10.0),
        FlutterSliderFixedValue(percent: 45, value: 12.0),
        FlutterSliderFixedValue(percent: 50, value: 14.0),
        FlutterSliderFixedValue(percent: 55, value: 16.0),
        FlutterSliderFixedValue(percent: 60, value: 18.0),
        FlutterSliderFixedValue(percent: 65, value: 20.0),
        FlutterSliderFixedValue(percent: 70, value: 24.0),
        FlutterSliderFixedValue(percent: 75, value: 28.0),
        FlutterSliderFixedValue(percent: 80, value: 32.0),
        FlutterSliderFixedValue(percent: 85, value: 48.0),
        FlutterSliderFixedValue(percent: 90, value: 64.0),
        FlutterSliderFixedValue(percent: 95, value: 128.0),
        FlutterSliderFixedValue(percent: 100, value: 256.0),
      ],
      //#endregion

      step: FlutterSliderStep(
        step: 5,
        isPercentRange: true,
      ),
      //#region callbacks onDrag([Started|Dragging|Completed])
      //onDragStarted: (handler, lower, upper) => _onSlide(lower),
      onDragging: (handler, lower, upper) => _onSlide(lower),
      //onDragCompleted: (handler, lower, upper) => _onSlide(lower),
      //#endregion
    );
  }
}
