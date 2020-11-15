import 'package:flutter/material.dart';
import 'package:ishop/app/places/map/map_provider.dart';
import 'package:ishop/app/places/map/map_view.dart';
import 'package:ishop/app/places/sheet/sheet_provider.dart';
import 'package:provider/provider.dart';

class PlacesView extends StatelessWidget {
  const PlacesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MapProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SheetProvider(),
        )
      ],
      child: Stack(
        children: <Widget>[
          Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            child: MapView(),
          ),
        ],
      ),
    );
  }
}
