import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/data/model/place_info.dart';
import 'package:ishop/data/service/places.dart';

/// Places Provider
class PlacesProvider extends ChangeNotifier {
  /// Places API
  PlacesProvider() : _places = Places();

  final Places _places;

  PlaceInfo? _selectedPlace;
  ScrollController? _scrollController;
  GoogleMapController? _mapController;

  /// placeInfoStream
  Stream<List<PlaceInfo>> get places => _places.placeInfoStream;

  /// selected place
  PlaceInfo? get selectedPlace => _selectedPlace;

  set selectedPlace(PlaceInfo? value) {
    if (_selectedPlace != value) {
      _selectedPlace = value;
      notifyListeners();
    }
  }

  /// scrollController
  ScrollController? get scrollController => _scrollController;

  set scrollController(ScrollController? value) {
    if (_scrollController != value) {
      _scrollController = value;
    }
  }

  /// device location
  LatLng get deviceLocation => _places.deviceLocation;

  /// google map controller
  GoogleMapController? get mapController => _mapController;

  set mapController(GoogleMapController? value) {
    if (_mapController != value) {
      _mapController = value;
    }
  }
}
