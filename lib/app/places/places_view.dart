import 'package:flutter/material.dart';
import 'package:ishop/app/places/map/map_view.dart';
import 'package:ishop/app/places/places_provider.dart';
import 'package:ishop/app/places/sheet/places_sheet.dart';
import 'package:ishop/app/places/sheet/places_sheet_animation.dart';
import 'package:provider/provider.dart';

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
          Container(
            width: sheetWidth,
            alignment: Alignment.bottomCenter,
            child: PlacesSheet(),
          ),
          Positioned(
            bottom: -6,
            left: -250,
            child: PlacesSheetAnimation(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 18.0,
                ),
                width: sheetWidth,
                height: 45.0,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.elliptical(20, 10),
                    topRight: Radius.elliptical(20, 10),
                  ),
                ),
                child: Container(
                  width: sheetWidth,
                  height: 20.0,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.lightBlue.shade50,
                        width: 5.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
