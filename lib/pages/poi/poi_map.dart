import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/model/poi_model.dart';
import 'package:provider/provider.dart';

class POIMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<POIProvider>(builder: (context, model, _) {
      var deviceLocation =
          context.select<POIProvider, LatLng>((p) => p.model.deviceLocation);
      var markers =
          context.select<POIProvider, Set<Marker>>((p) => p.model.markers);
      //#region GoogleMap
      return GoogleMap(
        //#region initialCameraPosition
        initialCameraPosition: CameraPosition(
          target: deviceLocation,
          zoom: 12,
        ),
        //#endregion
        //#region markers
        markers: markers,
        //#endregion
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        //#region onMapCreated
        onMapCreated: (mapController) {
          model.model.mapController.complete(mapController);
        },
        //#endregion
      );
      //#endregion
    });
  }
}
