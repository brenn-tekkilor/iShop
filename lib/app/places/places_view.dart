import 'package:flutter/material.dart';
import 'package:ishop/app/places/list/place_sheet.dart';
import 'package:ishop/app/places/map/map_view.dart';
import 'package:ishop/app/places/places_provider.dart';
import 'package:provider/provider.dart';

/// PlacesView
class PlacesView extends StatefulWidget {
  /// PlacesView default const constructor
  const PlacesView({Key? key}) : super(key: key);

  @override
  _PlacesViewState createState() => _PlacesViewState();
}

class _PlacesViewState extends State<PlacesView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sheetWidth = size.width * 0.75;
    final listHeight = size.height * 0.40;

    return ChangeNotifierProvider(
        create: (_) => PlacesProvider(),
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: <Widget>[
              Container(
                width: size.width,
                height: size.height,
                alignment: Alignment.center,
                child: const MapView(),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: sheetWidth,
                  height: size.height,
                  alignment: Alignment.bottomLeft,
                  child: const PlaceSheet(),
                ),
              ),
            ],
          ),
        ));
  }
}
