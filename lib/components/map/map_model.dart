import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:ishop/app/services/locator.dart';
import 'package:ishop/components/base/base_model.dart';
import 'package:ishop/components/places/places_service.dart';

@injectable
class MapModel extends BaseModel {
  MapModel() : _placesSrv = locator<PlacesService>();

  @factoryMethod
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
