import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class POIMap extends StatelessWidget {
  const POIMap({
    Key key,
    @required this.markers,
    @required this.initialPosition,
    @required this.mapController,
  }) : super(key: key);

  final Set<Marker> markers;
  final LatLng initialPosition;
  final Completer<GoogleMapController> mapController;

  @override
  Widget build(BuildContext context) {
    //#region GoogleMap
    return GoogleMap(
      //#region initialCameraPosition
      initialCameraPosition: CameraPosition(
        target: initialPosition,
        zoom: 12,
      ),
      //#endregion
      //#region markers
      markers: markers,
      //#endregion
      //#region onMapCreated
      onMapCreated: (mapController) {
        this.mapController.complete(mapController);
      },
      //#endregion
    );
    //#endregion
  }

  void _animateToPosition(LatLng position) async {
    await mapController.future
        .then(
          (controller) async => await controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: position,
                zoom: 12.0,
              ),
            ),
          ),
        )
        .catchError((err) => print(err));
  }
}
