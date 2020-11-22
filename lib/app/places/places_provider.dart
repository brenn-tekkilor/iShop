import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/data/model/place_info.dart';
import 'package:ishop/data/service/places_api.dart';

class PlacesProvider extends ChangeNotifier {
  PlacesProvider() : _api = PlacesAPI.instance();

  final PlacesAPI _api;
  PlaceInfo? selectedPlace;
  /*
  final ValueNotifier<PlaceInfo?> selectedPlaceNotifier = ValueNotifier<PlaceInfo?>(null);
  PlaceInfo? get selectedPlace => selectedPlaceNotifier.value;
  set selectedPlace(PlaceInfo? value) {
    if (selectedPlace != value) {
      selectedPlaceNotifier.value = value;
      _api.selectedPlace = value;
    }
  }
   */
  LatLng get deviceLocation => _api.deviceLocation;
  GoogleMapController? get placesMapController => _api.placesMapController;
  set placesMapController(GoogleMapController? value) =>
      _api.placesMapController = value;
  ValueListenable<bool> get sheetNotifier => _api.sheetNotifier;
}
