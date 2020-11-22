import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/data/enums/place_banner.dart';
import 'package:ishop/data/model/place_info.dart';
import 'package:ishop/data/service/geo_radius.dart';
import 'package:ishop/data/service/places_query_subject.dart';
import 'package:ishop/util/enum_parser.dart';
import 'package:ishop/util/extensions/latitude_longitude_adapter.dart';
import 'package:rxdart/rxdart.dart';

class PlacesAPI {
  //#region Ctor / factory
  //#region Ctor
  PlacesAPI._create()
      : _placeInfoController =
            BehaviorSubject<Set<PlaceInfo>>.seeded(<PlaceInfo>{}),
        _placesQueryController = BehaviorSubject<PlacesQuerySubject>.seeded(
            PlacesQuerySubject.initial()),
        _placesSet = <DocumentSnapshot>{},
        _banner = PlaceBanner.all,
        _radius = GeoRadius.defaultRadius,
        _deviceLocation = _defaultDeviceLocation,
        _sheetNotifier = ValueNotifier<bool>(false),
        _radiusCenter =
            _defaultDeviceLocation.to<GeoFirePoint>() as GeoFirePoint {
    _placeInfoController.onListen = _startSubscription;

    _placeInfoController.onCancel = _stopSubscription;
  }
  //#endregion
  factory PlacesAPI.instance() {
    return _instance;
  }

  static final PlacesAPI _instance = PlacesAPI._create();
  final BehaviorSubject<PlacesQuerySubject> _placesQueryController;
  final BehaviorSubject<Set<PlaceInfo>> _placeInfoController;
  final ValueListenable<bool> _sheetNotifier;
  StreamSubscription<Position>? _devicePositionSubscription;
  StreamSubscription<List<DocumentSnapshot>>? _placesSubscription;
  Set<DocumentSnapshot> _placesSet;
  PlaceBanner _banner;
  double _radius;
  GeoFirePoint _radiusCenter;
  LatLng _deviceLocation;
  PlaceInfo? selectedPlace;
  GoogleMapController? placesMapController;
  ScrollController? sheetScroller;

  Stream<List<DocumentSnapshot>> get _placesStream =>
      _placesQueryController.switchMap((s) => Geoflutterfire()
          .collection(collectionRef: s.q)
          .within(
              center: s.r.c, radius: s.r.r, field: 'd.g', strictMode: true));

  Stream<Set<PlaceInfo>> get placeInfoStream => _placeInfoController.stream;

  void _startSubscription() {
    _devicePositionSubscription ??= Geolocator.getPositionStream(
      distanceFilter: 800,
      timeInterval: 5,
    ).listen((value) => deviceLocation = value.to<LatLng>() as LatLng);
    _placesSubscription ??= _placesStream.listen((e) => placesSet = e.toSet());
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

  void _updatePlaces() {
    if (_placeInfoController.hasListener) {
      _placeInfoController.add(placesSet.map((e) {
        final d = e.data()['d'];
        return PlaceInfo(
          id: e.id,
          name: d['n'],
          banner: d['b'],
          latLng: (d['g']['geopoint'] as GeoPoint).to<LatLng>(),
        );
      }).toSet());
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
  ValueListenable<bool> get sheetNotifier => _sheetNotifier;
  bool get isSheetVisible => sheetNotifier.value;
  set isSheetVisible(bool value) {
    if (isSheetVisible != value) {
      (_sheetNotifier as ValueNotifier).value = value;
    }
  }

  Future<void> placesSheetScrollTo(String value) async {
    if (sheetScroller != null) {
      sheetScroller?.jumpTo(0.0);
      sheetScroller?.jumpTo(240.0);
      final i = placesSet
          .toList(
            growable: false,
          )
          .indexWhere((e) => e.id == value);
      await sheetScroller?.animateTo(60.0 * i,
          duration: Duration(milliseconds: 800), curve: Curves.easeInOut);
    }
  }
  //#endregion

  //#region GoogleMap controls
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
