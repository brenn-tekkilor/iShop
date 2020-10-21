import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/app/service_locator.dart';
import 'package:ishop/services/places_service.dart';
import 'package:ishop/views/base/base_model.dart';

class MapModel extends BaseModel {
  MapModel() : _placesSrv = locator<PlacesService>();

  factory MapModel.initial() {
    return MapModel();
  }

  final PlacesService _placesSrv;

  Stream<List<DocumentSnapshot>> get stream => _placesSrv.stream;

  LatLng get deviceLocation => _placesSrv.deviceLocation;

  set placesMap(GoogleMapController value) => _placesSrv.placesMap = value;

  @override
  void dispose() {
    super.dispose();
  }
}
