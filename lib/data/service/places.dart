import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/data/enums/place_banner.dart';
import 'package:ishop/data/model/geo_radius.dart';
import 'package:ishop/data/model/place_info.dart';
import 'package:ishop/data/service/places_query_subject.dart';
import 'package:ishop/util/enum_parser.dart';
import 'package:ishop/util/extensions/document_snapshot_extensions.dart';
import 'package:ishop/util/extensions/latitude_longitude_adapter.dart';
import 'package:rxdart/rxdart.dart';

/// Places
class Places {
  /// Places constructor
  Places()
      : _placeInfoController =
            BehaviorSubject<List<PlaceInfo>>.seeded(<PlaceInfo>[]),
        _placesQueryController = BehaviorSubject<PlacesQuerySubject>.seeded(
            PlacesQuerySubject.initial()),
        _placesDocs = <DocumentSnapshot>[],
        _queryBanner = PlaceBanner.all,
        _queryRadius = GeoRadius.defaultRadius,
        _deviceLocation = _defaultDeviceLocation {
    _placeInfoController
      ..onListen = _startSubscription
      ..onCancel = _stopSubscription;
  }
  final BehaviorSubject<PlacesQuerySubject> _placesQueryController;
  final BehaviorSubject<List<PlaceInfo>> _placeInfoController;
  StreamSubscription<Position>? _devicePositionSubscription;
  StreamSubscription<List<DocumentSnapshot>>? _placesSubscription;
  List<DocumentSnapshot> _placesDocs;
  PlaceBanner _queryBanner;
  double _queryRadius;
  LatLng _deviceLocation;

  Stream<List<DocumentSnapshot>> get _placesStream =>
      _placesQueryController.switchMap((s) => Geoflutterfire()
          .collection(collectionRef: s.q)
          .within(
              center: s.r.c, radius: s.r.r, field: 'd.g', strictMode: true));

  /// public place info stream
  Stream<List<PlaceInfo>> get placeInfoStream => _placeInfoController.stream;
  Stream<Position> get _deviceLocationStream => Geolocator.getPositionStream(
        distanceFilter: 800,
        intervalDuration: const Duration(seconds: 5),
      );

  void _startSubscription() {
    _devicePositionSubscription ??=
        _deviceLocationStream.listen(_updateLocation);
    _placesSubscription ??= _placesStream.listen(_updatePlaces);
  }

  void _stopSubscription() {
    if (_devicePositionSubscription != null) {
      _devicePositionSubscription?.cancel();
      _devicePositionSubscription = null;
    }
    if (_placesSubscription != null) {
      _placesSubscription?.cancel();
      _placesSubscription = null;
    }
  }

  void _updatePlaces(List<DocumentSnapshot> value) {
    _placesDocs = value;
    if (_placeInfoController.hasListener) {
      _placeInfoController
          .add(value.map((e) => e.placeInfo).toList(growable: false));
    }
  }

  void _updateLocation(Position value) {
    deviceLocation = value.to<LatLng>() ?? _defaultDeviceLocation;
  }

  GeoRadius get _queryGeoRadius => _placesQueryController.value.r;
  set _queryGeoRadius(GeoRadius value) {
    if (_queryGeoRadius != value) {
      _placesQueryController.value = _placesQueryController.value.copyWith(
        radius: value,
      );
    }
  }

  GeoFirePoint get _queryGeoRadiusFocus => _queryGeoRadius.c;
  set _queryGeoRadiusFocus(GeoFirePoint value) {
    if (_queryGeoRadiusFocus != value) {
      final dynamic d = _queryGeoRadiusFocus.haversineDistance(
        lat: value.latitude,
        lng: value.longitude,
      );
      if (d is double && d >= 800) {
        _queryGeoRadius = _queryGeoRadius.copyWith(
          lat: value.latitude,
          lng: value.longitude,
        );
      }
    }
  }

  double get _queryGeoRadiusFocusLatitude => _queryGeoRadius.latitude;
  double get _queryGeoRadiusFocusLongitude => _queryGeoRadius.longitude;

  /// query radius
  double get queryRadius => _queryRadius;
  set queryRadius(double value) {
    if (queryRadius != value) {
      final old = queryRadius;
      _queryRadius = value;
      if (value > old) {
        _queryGeoRadius = _queryGeoRadius.copyWith(
          rad: value,
        );
      } else {
        if (_placesDocs.isNotEmpty) {
          final docs = _placesDocs
              .where((e) =>
                  e.haversineDistance(
                      latitude: _queryGeoRadiusFocusLatitude,
                      longitude: _queryGeoRadiusFocusLongitude) <=
                  value)
              .toList(growable: false);
          _updatePlaces(docs);
        }
      }
    }
  }

  /// query place banner
  PlaceBanner get queryBanner => _queryBanner;
  set queryBanner(PlaceBanner value) {
    if (queryBanner != value) {
      final old = queryBanner;
      _queryBanner = value;
      if (old != PlaceBanner.all) {
        _placesQueryController.value = _placesQueryController.value.copyWith(
          banner: value,
        );
      } else {
        if (_placesDocs.isNotEmpty) {
          final stringValue = EnumParser.stringValue(value).toLowerCase();
          final docs = _placesDocs
              .where((e) => e.banner.toLowerCase() == stringValue)
              .toList();
          _updatePlaces(docs);
        }
      }
    }
  }

  /// device location
  LatLng get deviceLocation => _deviceLocation;
  set deviceLocation(LatLng value) {
    if (deviceLocation != value) {
      _deviceLocation = value;
      final focus = value.to<GeoFirePoint>();
      if (focus is GeoFirePoint) {
        _queryGeoRadiusFocus = focus;
      }
    }
  }

  static const _defaultDeviceLocation =
      LatLng(GeoRadius.defaultLatitude, GeoRadius.defaultLongitude);
}
