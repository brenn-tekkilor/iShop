import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/app/places/map/map_provider.dart';
import 'package:ishop/data/service/places_api.dart';
import 'package:provider/provider.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Set<Marker> markers = <Marker>{};
  StreamSubscription<Set<Marker>>? markerSubscription;
  void _updateMarkers(Set<Marker> value) {
    markers.clear();
    markers.addAll(value);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    markerSubscription =
        PlacesAPI.instance().markerStream.listen(_updateMarkers);
  }

  @override
  void dispose() {
    markerSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceLocation = context.select((MapProvider p) => p.deviceLocation);
    return GoogleMap(
      //#region initialCameraPosition
      initialCameraPosition: CameraPosition(
        target: deviceLocation,
        zoom: 12,
      ),
      //#endregion: :
      //#region markers
      markers: markers,
      //#endregion:
      zoomControlsEnabled: false,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      trafficEnabled: true,

      //#region onMapCreated
      onMapCreated: (mapController) {
        Provider.of<MapProvider>(context, listen: false).placesMapController =
            mapController;
      },
    );
  }
}
