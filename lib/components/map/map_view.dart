import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/app/services/locator.dart';
import 'package:ishop/components/map/map_model.dart';
import 'package:ishop/components/places/places_service.dart';
import 'package:ishop/core/models/place.dart';
import 'package:stacked/stacked.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final markers = <Marker>{};
  StreamSubscription<List<DocumentSnapshot>> stream;
  void addMarker(DocumentSnapshot doc) {
    if (doc != null &&
        doc.id != null &&
        doc.id.isNotEmpty &&
        !markers.any((m) => m.markerId.value == doc.id)) {
      markers.add(Place.fromDocument(doc).toMarker().copyWith(
          onTapParam: () => locator<PlacesService>().animateListTo(doc.id)));
    }
  }

  void updateMarkers(List<DocumentSnapshot> docs) {
    markers.clear();
    docs.forEach((doc) => addMarker(doc));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    stream = locator<PlacesService>().stream.listen(updateMarkers);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MapModel>.reactive(
      builder: (context, model, child) {
        return GoogleMap(
          //#region initialCameraPosition
          initialCameraPosition: CameraPosition(
            target: model.deviceLocation,
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
            model.placesMap = mapController;
          },
        );
      },
      viewModelBuilder: () => MapModel.initial(),
    );
  }
}