import 'package:flutter/material.dart';
import 'package:ishop/data/model/place_info.dart';

class MapPin extends StatefulWidget {
  MapPin({double pinPosition = -100, PlaceInfo selectedPin = _defaultPin})
      : pinPosition = pinPosition,
        currentlySelectedPin = selectedPin;

  final double pinPosition;

  final PlaceInfo currentlySelectedPin;

  @override
  State<StatefulWidget> createState() => MapPinState();

  static const _defaultPin = PlaceInfo();
}

class MapPinState extends State<MapPin> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      bottom: widget.pinPosition,
      right: 0,
      left: 0,
      duration: Duration(milliseconds: 200),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.all(20),
          height: 70,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(50)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    blurRadius: 20,
                    offset: Offset.zero,
                    color: Colors.grey.withOpacity(0.5))
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 100,
                height: 50,
                margin: EdgeInsets.only(left: 10),
                child: ClipRect(
                    child: Image.asset(widget.currentlySelectedPin.logoPath,
                        fit: BoxFit.cover)),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(widget.currentlySelectedPin.title,
                          style: TextStyle(
                              color: widget.currentlySelectedPin.labelColor)),
                      Text(widget.currentlySelectedPin.name,
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      Text(
                          'Latitude: ${widget.currentlySelectedPin.latLng.latitude.toString()}, Longitude: ${widget.currentlySelectedPin.latLng.longitude.toString()}',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Image.asset(widget.currentlySelectedPin.pinPath,
                    width: 50, height: 50),
              )
            ],
          ),
        ),
      ),
    );
  }
}
