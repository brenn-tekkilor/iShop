import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/data/enums/place_banner.dart';
import 'package:ishop/data/model/place.dart';
import 'package:ishop/data/service/geo_radius.dart';
import 'package:ishop/data/service/places_query_subject.dart';
import 'package:ishop/util/enum_parser.dart';
import 'package:ishop/util/extensions/document_snapshot_extensions.dart';
import 'package:ishop/util/extensions/latitude_longitude_adapter.dart';
import 'package:rxdart/rxdart.dart';

class PlacesAPI {
  //#region Ctor / factory
  //#region Ctor
  PlacesAPI._create()
      : _markerController = BehaviorSubject<Set<Marker>>.seeded(<Marker>{}),
        _cardController = BehaviorSubject<Set<Card>>.seeded(<Card>{}),
        _placesQueryController = BehaviorSubject<PlacesQuerySubject>.seeded(
            PlacesQuerySubject.initial()),
        _placesSet = <DocumentSnapshot>{},
        _banner = PlaceBanner.all,
        _radius = GeoRadius.defaultRadius,
        _deviceLocation = _defaultDeviceLocation,
        _radiusCenter =
            _defaultDeviceLocation.to<GeoFirePoint>() as GeoFirePoint {
    _markerController.onListen = _cardController.onListen = _startSubscriptions;
    _markerController.onCancel = () {
      if (!_cardController.hasListener) {
        _stopSubscriptions;
      }
    };
    _cardController.onCancel = () {
      if (!_markerController.hasListener) {
        _stopSubscriptions();
      }
    };
  }
  //#endregion
  factory PlacesAPI.instance() {
    return _instance;
  }

  static final PlacesAPI _instance = PlacesAPI._create();
  final BehaviorSubject<PlacesQuerySubject> _placesQueryController;
  final BehaviorSubject<Set<Marker>> _markerController;
  final BehaviorSubject<Set<Card>> _cardController;
  StreamSubscription<Position>? _devicePositionSubscription;
  StreamSubscription<List<DocumentSnapshot>>? _placesSubscription;
  Set<DocumentSnapshot> _placesSet;
  PlaceBanner _banner;
  double _radius;
  GeoFirePoint _radiusCenter;
  Place? preferredPlace;
  LatLng _deviceLocation;

  Stream<List<DocumentSnapshot>> get _placesStream =>
      _placesQueryController.switchMap((s) => Geoflutterfire()
          .collection(collectionRef: s.q)
          .within(
              center: s.r.c, radius: s.r.r, field: 'd.g', strictMode: true));

  Stream<Set<Marker>> get markerStream => _markerController.stream;
  Stream<Set<Card>> get cardStream => _cardController.stream;

  void _startSubscriptions() {
    _devicePositionSubscription ??= Geolocator.getPositionStream(
      distanceFilter: 800,
      timeInterval: 5,
    ).listen((value) => deviceLocation = value.to<LatLng>() as LatLng);
    _placesSubscription ??= _placesStream.listen((e) => placesSet = e.toSet());
  }

  void _stopSubscriptions() {
    if (_devicePositionSubscription != null) {
      _devicePositionSubscription?.cancel();
      _devicePositionSubscription = null;
    }
    if (_placesSubscription != null) {
      _placesSubscription?.cancel();
      _placesSubscription = null;
    }
  }

  void _updatePlaces() {
    if (_markerController.hasListener) {
      _markerController.add(placesSet.map((e) => e.toMarker()).toSet());
    }
    if (_cardController.hasListener) {
      _cardController.add(placesSet.map((e) => e.toCard()).toSet());
    }
  }

  Set<DocumentSnapshot> get placesSet => _placesSet;
  set placesSet(Set<DocumentSnapshot> value) {
    if (_placesSet != value) {
      _placesSet = value;
      _updatePlaces();
    }
  }

  PlacesQuerySubject get placesQuerySubject => _placesQueryController.value;

  set placesQuerySubject(PlacesQuerySubject value) {
    if (placesQuerySubject != value) {
      _placesQueryController.add(value);
    }
  }

  GeoRadius get placesQueryGeoRadius => placesQuerySubject.r;
  set placesQueryGeoRadius(GeoRadius value) {
    if (placesQueryGeoRadius != value) {
      placesQuerySubject = placesQuerySubject.copyWith(
        radius: value,
      );
    }
  }

  GeoFirePoint get placesQueryGeoRadiusCenter => placesQueryGeoRadius.c;
  set placesQueryGeoRadiusCenter(GeoFirePoint value) {
    if (placesQueryGeoRadiusCenter != value &&
        placesQueryGeoRadiusCenter.distance(
              lat: value.latitude,
              lng: value.longitude,
            ) >
            800) {
      placesQueryGeoRadius = placesQueryGeoRadius.copyWith(
        lat: value.latitude,
        lng: value.longitude,
      );
    }
  }

  double get placesQueryRadiusCenterLatitude => placesQueryGeoRadius.latitude;
  double get placesQueryRadiusCenterLongitude => placesQueryGeoRadius.longitude;

  double get placesQueryRadius => placesQueryGeoRadius.r;
  set placesQueryRadius(double value) {
    if (placesQueryRadius != value) {
      placesQueryGeoRadius = placesQueryGeoRadius.copyWith(
        rad: value,
      );
    }
  }

  double get radius => _radius;
  set radius(double value) {
    if (radius != value) {
      final old = radius;
      _radius = value;
      if (value > old) {
        placesQueryRadius = value;
      } else {
        if (placesSet.isNotEmpty) {
          placesSet.removeWhere((e) =>
              (e.data()['d']['g'] as GeoFirePoint).haversineDistance(
                lat: placesQueryRadiusCenterLatitude,
                lng: placesQueryRadiusCenterLongitude,
              ) >
              value);
          _updatePlaces();
        }
      }
    }
  }

  GeoFirePoint get radiusCenter => _radiusCenter;
  set radiusCenter(GeoFirePoint value) {
    if (radiusCenter != value) {
      _radiusCenter = value;
      if (placesQueryGeoRadiusCenter.distance(
              lat: value.latitude, lng: value.longitude) >
          800) {
        placesQueryGeoRadiusCenter = value;
      }
    }
  }

  PlaceBanner get banner => _banner;
  set banner(PlaceBanner value) {
    if (banner != value) {
      final old = banner;
      _banner = value;
      if (old != PlaceBanner.all) {
        placesQuerySubject = placesQuerySubject.copyWith(
          banner: value,
        );
      } else {
        if (placesSet.isNotEmpty) {
          final stringValue = EnumParser.stringValue(value).toLowerCase();
          placesSet.removeWhere((e) =>
              (e.data()['d']['b'] as String).toLowerCase() != stringValue);
          _updatePlaces();
        }
      }
    }
  }

  LatLng get deviceLocation => _deviceLocation;
  set deviceLocation(LatLng value) {
    if (deviceLocation != value) {
      _deviceLocation = value;
      placesQueryGeoRadiusCenter = value.to<GeoFirePoint>() as GeoFirePoint;
    }
  }

  //#region places sheet scroll controller controls
  ScrollController? placesSheetScrollController;
  Future<void> placesSheetScrollTo(String value) async {
    if (placesSheetScrollController != null) {
      placesSheetScrollController?.jumpTo(0.0);
      placesSheetScrollController?.jumpTo(240.0);
      final i = placesSet
          .toList(
            growable: false,
          )
          .indexWhere((e) => e.id == value);
      await placesSheetScrollController?.animateTo(60.0 * i,
          duration: Duration(milliseconds: 800), curve: Curves.easeInOut);
    }
  }
  //#endregion

  //#region GoogleMap controls
  GoogleMapController? placesMapController;
  Future<void> animateMapTo(LatLng latLng) async =>
      await placesMapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLng,
          zoom: 16,
        ),
      ));
  Future<void> animateMapZoom(double value) async =>
      await placesMapController?.animateCamera(CameraUpdate.zoomTo(value));
//#endregion
  static const _defaultDeviceLocation =
      LatLng(GeoRadius.defaultLatitude, GeoRadius.defaultLongitude);
}
