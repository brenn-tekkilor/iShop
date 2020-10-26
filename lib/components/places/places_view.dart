import 'package:flutter/material.dart';
import 'package:ishop/components/map/map_view.dart';

class PlacesView extends StatelessWidget {
  const PlacesView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      child: MapView(),
    );
  }
}
