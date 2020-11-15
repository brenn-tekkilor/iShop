import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/data/service/places_api.dart';

class MapProvider extends ChangeNotifier {
  MapProvider() : _api = PlacesAPI.instance();

  final PlacesAPI _api;
  LatLng get deviceLocation => _api.deviceLocation;
  GoogleMapController? get placesMapController => _api.placesMapController;
  set placesMapController(GoogleMapController? value) =>
      _api.placesMapController = value;
}
