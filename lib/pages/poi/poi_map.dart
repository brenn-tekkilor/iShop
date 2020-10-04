import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/pages/poi/poi_state.dart';
import 'package:ishop/utils/map_utils.dart';

class POIMap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _POIMapState();
}

class _POIMapState extends State<POIMap> {
  //#region POI Map Markers mgmnt

  final markers = <Marker>{};

  //#region poiMap marker methods

  void _addMarker(Marker value) {
    assert(value != null);
    if (!markers.contains(value)) {
      markers.removeWhere((e) => e.markerId.value == value.markerId.value);
      markers.add(value);
    }
  }

  Marker _docToMarker(DocumentSnapshot doc) {
    final data = doc.data();
    final banner = data['meta']['banner'];
    final point = data['point']['geopoint'];
    return Marker(
      markerId: MarkerId(doc.id),
      position: geoPointToLatLng(point),
      icon: banner == 'marketplace'
          ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
          : BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(
        title: data['name'],
        snippet: banner,
      ),
    );
  }

  void _updateMarkers(List<DocumentSnapshot> docs) {
    markers.clear();
    docs.forEach((e) => _addMarker(_docToMarker(e)));
    setState(() {});
  }

  //#endregion

  LatLng location;

  Completer controller;
  POIState data;
  StreamSubscription<List<DocumentSnapshot>> subscription;

//#endregion

  @override
  Widget build(BuildContext context) {
    data ??= POIStateContainer.of(context).state;
    subscription = data.poiStream.listen(_updateMarkers);
    location = data.deviceLocation;
    controller = data.mapController;
    //#region GoogleMap
    return GoogleMap(
      //#region initialCameraPosition
      initialCameraPosition: CameraPosition(
        target: location,
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
        controller.complete(mapController);
      },
      //#endregion
    );
    //#endregion
  }
}
