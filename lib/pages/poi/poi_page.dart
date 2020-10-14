import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ishop/pages/poi/poi_map.dart';
import 'package:ishop/pages/poi/poi_scroll.dart';
import 'package:ishop/pages/poi/poi_state.dart';

class POIPage extends StatefulWidget {
  POIPage({Key key, @required this.data}) : super(key: key);
  final LocationData data;
  @override
  State<StatefulWidget> createState() => _POIPageState();
}

class _POIPageState extends State<POIPage> with TickerProviderStateMixin {
  POIMap get _map => POIMap();
  POIScroll get _scroll => POIScroll();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return LocationDataProvider(
      locationData: widget.data,
      child: Scaffold(
        body: Builder(
          builder: (BuildContext context) => Center(
            child: Column(
              children: <Widget>[
                Container(
                  width: width,
                  height: height,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: width,
                        height: height,
                        child: _map,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: _scroll,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
