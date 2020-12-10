import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:geoflutterfire/geoflutterfire.dart'
    show Coordinates, GeoFirePoint, Geoflutterfire;
import 'package:geolocator/geolocator.dart' show Position;
import 'package:ishop/app/app_provider.dart';
import 'package:ishop/data/enums/place_banner.dart' show PlaceBanner;
import 'package:ishop/data/model/geo_radius.dart' show GeoRadius;
import 'package:ishop/data/model/place_details.dart' show PlaceDetails;
import 'package:ishop/data/service/places_query_subject.dart'
    show PlacesQuerySubject;
import 'package:ishop/util/extensions/document_snapshot_extensions.dart';
import 'package:ishop/util/extensions/latitude_longitude_adapter.dart';
import 'package:rxdart/rxdart.dart';

/// Places
class PlacesAPI {
  /// Places constructor
  PlacesAPI()
      : _placeInfoController =
            BehaviorSubject<List<PlaceDetails>>.seeded(<PlaceDetails>[]),
        _placesQueryController = BehaviorSubject<PlacesQuerySubject>.seeded(
            PlacesQuerySubject.initial()),
        _placesDocs = <DocumentSnapshot>[],
        _queryBanner = PlaceBanner.all,
        _queryRadius = GeoRadius.defaultRadius {
    _placeInfoController
      ..onListen = _startSubscription
      ..onCancel = _stopSubscription;
  }
  final BehaviorSubject<PlacesQuerySubject> _placesQueryController;
  final BehaviorSubject<List<PlaceDetails>> _placeInfoController;
  StreamSubscription<Position>? _devicePositionSubscription;
  StreamSubscription<List<DocumentSnapshot>>? _placesSubscription;
  List<DocumentSnapshot> _placesDocs;
  PlaceBanner _queryBanner;
  double _queryRadius;

  Stream<List<DocumentSnapshot>> get _placesStream =>
      _placesQueryController.switchMap((s) => Geoflutterfire()
          .collection(collectionRef: s.q)
          .within(
              center: s.r.c, radius: s.r.r, field: 'd.g', strictMode: true));

  /// public place info stream
  Stream<List<PlaceDetails>> get placeInfoStream => _placeInfoController.stream;

  /// deviceLocationStream

  void _startSubscription() {
    _devicePositionSubscription ??=
        AppProvider.deviceLocationStream.listen(_updateLocation);
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
          .add(value.map((e) => e.placeDetails).toList(growable: false));
    }
  }

  void _updateLocation(Position value) {
    final focus = value.to<GeoFirePoint>();
    if (focus is GeoFirePoint) {
      _queryGeoRadiusFocus = focus;
    }
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
                  GeoFirePoint.distanceBetween(
                      to: Coordinates(e.latitude, e.longitude),
                      from: Coordinates(_queryGeoRadiusFocusLatitude,
                          _queryGeoRadiusFocusLongitude)) <=
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
          final docs = _placesDocs.where((e) => e.banner == value).toList();
          _updatePlaces(docs);
        }
      }
    }
  }
}
