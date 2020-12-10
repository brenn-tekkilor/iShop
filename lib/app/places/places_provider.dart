import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/app/app_provider.dart';
import 'package:ishop/data/enums/place_banner.dart';
import 'package:ishop/data/model/place_details.dart';
import 'package:ishop/data/service/places_api.dart';
import 'package:ishop/util/solver.dart';

/// Places Provider
class PlacesProvider extends ChangeNotifier {
  //#region constructor
  /// PlacesProvider constructor
  PlacesProvider()
      : _api = PlacesAPI(),
        _sliderValue = 0,
        _selectedBanner = PlaceBanner.all;

  //#endregion
  //#region properties
  final PlacesAPI _api;
  PlaceBanner _selectedBanner;
  PlaceDetails? _selectedPlace;
  ScrollController? _scrollController;
  GoogleMapController? _mapController;
  double _sliderValue;

  //#endregion
  //#region getters/setters
  /// placeInfoStream
  Stream<List<PlaceDetails>> get places => _api.placeInfoStream;

  /// selected place
  PlaceDetails? get selectedPlace => _selectedPlace;
  set selectedPlace(PlaceDetails? value) {
    if (selectedPlace != value) {
      _selectedPlace = value;
      notifyListeners();
    }
    if (selectedPlace != null) {
      _animateMapTo(value?.latLng);
    }
  }

  /// selectedBanner
  PlaceBanner get selectedBanner => _selectedBanner;
  set selectedBanner(PlaceBanner value) {
    if (selectedBanner != value) {
      _selectedBanner = value;
      _api.queryBanner = _selectedBanner;
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
  LatLng get deviceLocation => AppProvider.deviceLocation;

  /// google map controller
  GoogleMapController? get mapController => _mapController;
  set mapController(GoogleMapController? value) {
    if (_mapController != value) {
      _mapController = value;
    }
  }

  /// miles
  int get miles => (_api.queryRadius * 0.621371).round();

  /// sliderValue
  double get sliderValue => _sliderValue;
  set sliderValue(double value) {
    if (value > 0) {
      final division = Solver.nearestMultipleInt(value, 10).toDouble();
      if (sliderValue != division) {
        _sliderValue = division;
        _api.queryRadius = (1.32008 * pow(1.04149, sliderValue)).toDouble();
        _sliderOnChange();
        notifyListeners();
      }
    }
  }

  //#endregion
  //#region methods
  /// animates google map
  Future<void> _animateMapTo(LatLng? latLng) async =>
      await _mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLng,
          zoom: 16,
        ),
      ));

  /// syncs google map zoom level with slider value
  Future<void> _sliderOnChange() async => await _mapController?.animateCamera(
      CameraUpdate.zoomTo(((-0.03 * sliderValue) + 12.1).roundToDouble()));
//#endregion
}
