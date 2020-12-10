import 'dart:async';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/data/model/geo_radius.dart';
import 'package:ishop/data/model/place_details.dart';
import 'package:ishop/util/extensions/latitude_longitude_adapter.dart';
import 'package:url_launcher/url_launcher.dart';

/// HomeProvider
class AppProvider extends ChangeNotifier {
  /// HomeProvider constructor
  AppProvider() {
    _devicePositionSubscription ??=
        deviceLocationStream.listen(_updateLocation);
  }

  static LatLng _deviceLocation = defaultDeviceLocation;
  PlaceDetails? _preferredPlace;
  StreamSubscription<Position>? _devicePositionSubscription;

  /// deviceLocationStream
  static Stream<Position> get deviceLocationStream =>
      Geolocator.getPositionStream(
        distanceFilter: 800,
        intervalDuration: const Duration(seconds: 5),
      );

  /// deviceLocation
  static LatLng get deviceLocation => _deviceLocation;
  static set deviceLocation(LatLng value) {
    if (deviceLocation != value) {
      _deviceLocation = value;
    }
  }

  /// preferredPlace
  PlaceDetails? get preferredPlace => _preferredPlace;
  set preferredPlace(PlaceDetails? value) {
    if (preferredPlace != value) {
      _preferredPlace = value;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    if (_devicePositionSubscription != null) {
      _devicePositionSubscription?.cancel();
      _devicePositionSubscription = null;
    }
    super.dispose();
  }

  void _updateLocation(Position value) {
    deviceLocation = value.to<LatLng>() ?? defaultDeviceLocation;
  }

  /// launchMapsUrl
  Future<void> startNavigation({Set<LatLng>? waypoints}) async {
    final e = preferredPlace?.latLng ?? defaultDeviceLocation;
    final _mapOptions = [
      'api=1',
      'origin=${deviceLocation.latitude},${deviceLocation.longitude}',
      'destination=${e.latitude},${e.longitude}',
    ];
    if (waypoints != null && waypoints.isNotEmpty) {
      final a = waypoints
          .map((e) => '${e.latitude}, ${e.longitude}')
          .toList(growable: false);
      _mapOptions.add("waypoints=${a.join('|')}");
    }
    _mapOptions.addAll(<String>['travelmode=driving', 'dir_action=navigate']);
    final url = "https://www.google.com/maps/dir/?${_mapOptions.join('&')}";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  /// defaultDeviceLocation
  static const defaultDeviceLocation =
      LatLng(GeoRadius.defaultLatitude, GeoRadius.defaultLongitude);
}
