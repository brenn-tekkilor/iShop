import 'dart:async';
import 'dart:math' show pow;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/model/places.dart';
import 'package:ishop/utils/map_utils.dart';
import 'package:ishop/utils/util.dart';
import 'package:rxdart/rxdart.dart';

class POIStreamControlBehaviorSubject {
  const POIStreamControlBehaviorSubject(this.ref, this.rad);
  final dynamic ref;
  final double rad;
}

class AppData {
  //#region ctor

  AppData()
      : _markers = <Marker>{},
        _poiDocs = FirebaseFirestore.instance.collection('maplocationmarkers'),
        _positionStream = getPositionStream(distanceFilter: 2, timeInterval: 4),
        _streamingBannerNotifier = ValueNotifier<BannerType>(BannerType.all),
        _streamingRadiusNotifier = ValueNotifier<double>(4.0),
        _preferredStoreNotifier = ValueNotifier<RetailLocation>(null),
        _poiStreamController = BehaviorSubject.seeded(
            POIStreamControlBehaviorSubject(
                FirebaseFirestore.instance.collection('maplocationmarkers'),
                4.0)) {
    _devicePositionStreamSubscription =
        _positionStream.listen((value) => _onStreamedPosition(value));
  }

  //#endregion

  //#region properties
  final CollectionReference _poiDocs;
  final Set<Marker> _markers;
  final Stream<Position> _positionStream;
  final ValueNotifier<BannerType> _streamingBannerNotifier;
  final ValueNotifier<double> _streamingRadiusNotifier;
  final ValueNotifier<RetailLocation> _preferredStoreNotifier;
  final BehaviorSubject<POIStreamControlBehaviorSubject> _poiStreamController;
  GoogleMapController _poiGoogleMapController;
  LatLng _currentDeviceLocation;
  ScrollController _poiDraggableScrollableScrollController;
  StreamSubscription<Position> _devicePositionStreamSubscription;
  Stream<List<DocumentSnapshot>> _poiStream;

  //#endregion

  //#endregion

  //#region methods

  //#region async methods

  Future<AppData> initialize() async {
    _currentDeviceLocation = posToLatLng(await getCurrentPosition());
    _poiStream = await initializePOIStream();
    return await this;
  }

  //#region get poiStream

  Future<Stream<List<DocumentSnapshot>>> initializePOIStream() async =>
      await poiController.switchMap((s) => geo
          .collection(collectionRef: s.ref)
          .within(
              center: latLngToGeoFirePoint(deviceLocation),
              radius: s.rad,
              field: 'point',
              strictMode: true));

  //#endregion

  Future<void> animateMapToLatLng(LatLng latLng) async =>
      await mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLng,
          zoom: 16,
        ),
      ));

  Future<void> animateMapToZoomLevel(double value) async =>
      await mapController.animateCamera(CameraUpdate.zoomTo(value));

  Future<void> showMapMarkerInfo(MarkerId value) async {
    if (value != null) {
      await mapController.isMarkerInfoWindowShown(value).then((result) async {
        final isShown = await result;
        if (!isShown) {
          await mapController.showMarkerInfoWindow(value);
        }
      }).catchError((e) => print(e));
    }
  }
//#endregion

  //#region callbacks

  void _onStreamedPosition(Position value) {
    if (value != null) {
      final location = posToLatLng(value);
      if (deviceLocation != null) {
        if (latLngDistance(_currentDeviceLocation, location) >=
            (0.000929079 * pow(streamingRadius, 2) + 2)) {
          _currentDeviceLocation = location;
        }
      } else {
        _currentDeviceLocation = location;
      }
    }
  }

  //#endregion

  //#region getters/setters

  //#region getters

  GoogleMapController get mapController => _poiGoogleMapController;

  ValueNotifier<RetailLocation> get preferredStoreNotifier =>
      _preferredStoreNotifier;

  RetailLocation get preferredStore => _preferredStoreNotifier.value;

  set preferredStore(RetailLocation value) {
    if (value != null && _preferredStoreNotifier.value != value) {
      _preferredStoreNotifier.value = value;
    }
  }

  ScrollController get poiScrollController =>
      _poiDraggableScrollableScrollController;

  Stream<List<DocumentSnapshot>> get poiStream => _poiStream;

  Set<Marker> get markers => _markers;

  ValueNotifier<BannerType> get streamingBannerListenable =>
      _streamingBannerNotifier;

  BannerType get streamingBanner => _streamingBannerNotifier.value;

  dynamic get poiRef => streamingBanner == BannerType.all
      ? _poiDocs
      : _poiDocs.where('meta.banner',
          isEqualTo: EnumParser.enumValueToString<BannerType>(streamingBanner));

  CollectionReference get poiDocs => _poiDocs;

  LatLng get deviceLocation => _currentDeviceLocation;

  StreamSubscription<Position> get positionSubscription =>
      _devicePositionStreamSubscription;

  ValueNotifier<double> get streamingRadiusListenable =>
      _streamingRadiusNotifier;
  double get streamingRadius => _streamingRadiusNotifier.value;

  BehaviorSubject<POIStreamControlBehaviorSubject> get poiController =>
      _poiStreamController;

  //#endregion

  //#region setters

  set mapController(GoogleMapController value) =>
      _poiGoogleMapController = value;

  set poiScrollController(ScrollController value) {
    assert(value != null);
    _poiDraggableScrollableScrollController = value;
  }

  set streamingRadius(double value) {
    assert(value != null);
    if (streamingRadius != value) {
      _streamingRadiusNotifier.value = value;
      if (streamingBanner != null) {
        poiController.add(POIStreamControlBehaviorSubject(poiRef, value));
      }
    }
  }

  set streamingBanner(BannerType value) {
    assert(value != null);
    if (_streamingBannerNotifier.value != value) {
      _streamingBannerNotifier.value = value;
      if (streamingRadius != null && streamingRadius > 0) {
        poiController
            .add(POIStreamControlBehaviorSubject(poiRef, streamingRadius));
      }
    }
  }
}

//#endregion

//#endregion

//#endregion

//#region classes for implementing the InheritedWidget state management model

class AppState extends StatefulWidget {
  AppState({@required this.child, @required this.state});
  final Widget child;
  final AppData state;

  static AppStateState of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<_InheritedAppState>()).data;

  @override
  AppStateState createState() => AppStateState(state: state);
}

class AppStateState extends State<AppState> {
  AppStateState({@required this.state});

  AppData state;

  @override
  Widget build(BuildContext context) {
    return _InheritedAppState(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedAppState extends InheritedWidget {
  _InheritedAppState({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  // Data is the entire POI state
  final AppStateState data;

  // This is a built in method which you can use to check if
  // any state has changed. If not, no reason to rebuild all the widgets
  // that rely on your state.
  @override
  bool updateShouldNotify(_InheritedAppState old) => true;
}

//#endregion
