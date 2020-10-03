import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:ishop/model/poi_model.dart';
import 'package:provider/provider.dart';

class POISlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<POIProvider>(builder: (context, model, _) {
      var radius = context.select<POIProvider, double>((p) => p.model.radius);
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
        values: [radius],
        //#region fixedValues[]
        fixedValues: [
          FlutterSliderFixedValue(percent: 0, value: 2.0),
          FlutterSliderFixedValue(percent: 8, value: 2.2),
          FlutterSliderFixedValue(percent: 17, value: 2.8),
          FlutterSliderFixedValue(percent: 25, value: 3.2),
          FlutterSliderFixedValue(percent: 33, value: 4.0),
          FlutterSliderFixedValue(percent: 42, value: 4.8),
          FlutterSliderFixedValue(percent: 50, value: 5.2),
          FlutterSliderFixedValue(percent: 58, value: 6.4),
          FlutterSliderFixedValue(percent: 67, value: 16.2),
          FlutterSliderFixedValue(percent: 75, value: 32.4),
          FlutterSliderFixedValue(percent: 83, value: 64.8),
          FlutterSliderFixedValue(percent: 92, value: 128.2),
          FlutterSliderFixedValue(percent: 100, value: 256.4),
        ],
        //#endregion
        hatchMark: FlutterSliderHatchMark(
          density: 0.5, // means 50 lines, from 0 to 100 percent
          //#region labels
          labels: [
            FlutterSliderHatchMarkLabel(percent: 0, label: Text('2 km')),
            FlutterSliderHatchMarkLabel(percent: 25, label: Text('3')),
            FlutterSliderHatchMarkLabel(percent: 50, label: Text('5')),
            FlutterSliderHatchMarkLabel(percent: 75, label: Text('32')),
            FlutterSliderHatchMarkLabel(percent: 100, label: Text('256 km')),
          ],
          //#endregion
        ),
        //#region callbacks onDrag([Started|Dragging|Completed])
        onDragging: (handler, lower, upper) => radius = lower,
        onDragCompleted: (handler, lower, upper) => radius = lower,
      );
    });
  }
}
