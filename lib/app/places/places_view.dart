import 'package:flutter/material.dart';
import 'package:ishop/app/places/list/places_list_expandable_panel_animation.dart';
import 'package:ishop/app/places/map/map_view.dart';
import 'package:ishop/app/places/places_provider.dart';
import 'package:provider/provider.dart';

import 'list/places_list.dart';

class PlacesView extends StatelessWidget {
  const PlacesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sheetWidth = size.width * 0.75;

    return ChangeNotifierProvider(
      create: (context) => PlacesProvider(),
      child: Stack(
        children: <Widget>[
          Container(
            width: size.width,
            height: size.height,
            alignment: Alignment.center,
            child: MapView(),
          ),
          Positioned(
            bottom: 100,
            left: -250,
            child: Container(
              width: sheetWidth,
              height: size.height * 0.40,
              alignment: Alignment.bottomCenter,
              child: PlacesListExpandablePanelAnimation(
                child: PlacesList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
