import 'package:flutter/material.dart';
import 'package:ishop/app/places/controls/place_range.dart';
import 'package:ishop/app/places/controls/slide_out_options/slide_out_options.dart';
import 'package:ishop/app/places/list/place_sheet.dart';
import 'package:ishop/app/places/map/map_view.dart';
import 'package:ishop/app/places/places_provider.dart';
import 'package:ishop_map_marker_info_window/ishop_map_marker_info_window.dart';
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
    final width = size.width;
    final height = size.height;
    final sheetWidth = size.width * 0.75;

    return ChangeNotifierProvider(
        create: (_) => PlacesProvider(),
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: <Widget>[
              Container(
                width: width,
                height: height,
                alignment: Alignment.center,
                child: const MapView(),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: sheetWidth,
                  height: height,
                  alignment: Alignment.bottomLeft,
                  child: const PlaceSheet(),
                ),
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: PlaceRange(),
              ),
              const Positioned(
                right: 0,
                top: 175,
                width: 150,
                height: 70,
                child: SlideOutOptions(),
              ),
              const IShopMapMarkerInfoWindow(),
            ],
          ),
        ));
  }
}
