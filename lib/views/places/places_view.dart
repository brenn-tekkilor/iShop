import 'package:flutter/material.dart';
import 'package:ishop/app/service_locator.dart';
import 'package:ishop/views/map/map_view.dart';

class PlacesView extends StatelessWidget {
  const PlacesView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: locator.allReady(),
        builder: (context, snapshot) => snapshot.hasData
            ? Stack(
                children: <Widget>[
                  Container(
                    width: width,
                    height: height,
                    alignment: Alignment.center,
                    child: MapView(),
                  ),
                ],
              )
            : CircularProgressIndicator());
  }
}
