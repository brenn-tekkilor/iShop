import 'dart:async';
import 'dart:math' show pow;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/utils/map_utils.dart';
import 'package:ishop/utils/util.dart';
import 'package:rxdart/rxdart.dart';

class POIStreamControlBehaviorSubject {
  const POIStreamControlBehaviorSubject(this.ref, this.rad);
  final dynamic ref;
  final double rad;
}

class POIStateData {
  //#region ctor

  POIStateData()
      : _markers = <Marker>{},
        _poiDocs = FirebaseFirestore.instance.collection('maplocationmarkers'),
        _poiGoogleMapController = Completer(),
        _positionStream = getPositionStream(distanceFilter: 2, timeInterval: 4),
        _poiFilterByBannerType = BannerType.all,
        _poiFilterByRadius = 4.0 {
    _poiStreamController =
        BehaviorSubject.seeded(POIStreamControlBehaviorSubject(poiRef, radius));
    _devicePositionStreamSubscription =
        _positionStream.listen((value) => _onStreamedPosition(value));
  }

  //#endregion

  //#region properties
  final CollectionReference _poiDocs;
  final Set<Marker> _markers;
  final Stream<Position> _positionStream;

  //#region variable properties

  BehaviorSubject<POIStreamControlBehaviorSubject> _poiStreamController;
  LatLng _currentDeviceLocation;
  double _poiFilterByRadius;
  final Completer<GoogleMapController> _poiGoogleMapController;
  ScrollController _poiDraggableScrollableScrollController;
  StreamSubscription<Position> _devicePositionStreamSubscription;
  BannerType _poiFilterByBannerType;
  Stream<List<DocumentSnapshot>> _poiStream;

  //#endregion

  //#endregion

  //#region methods

  //#region async methods

  Future<POIStateData> initialize() async {
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

//#endregion

  //#region callbacks

  void _onStreamedPosition(Position value) {
    if (value != null) {
      final location = posToLatLng(value);
      if (deviceLocation != null) {
        if (latLngDistance(_currentDeviceLocation, location) >=
            (0.000929079 * pow(radius, 2) + 2)) {
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

  ScrollController get poiScrollController =>
      _poiDraggableScrollableScrollController;

  Stream<List<DocumentSnapshot>> get poiStream => _poiStream;

  Set<Marker> get markers => _markers;

  BannerType get filter => _poiFilterByBannerType;

  dynamic get poiRef => filter == BannerType.all
      ? _poiDocs
      : _poiDocs.where('meta.banner', isEqualTo: enumValue<BannerType>(filter));

  CollectionReference get poiDocs => _poiDocs;

  Completer<GoogleMapController> get mapController => _poiGoogleMapController;

  LatLng get deviceLocation => _currentDeviceLocation;

  StreamSubscription<Position> get positionSubscription =>
      _devicePositionStreamSubscription;

  double get radius => _poiFilterByRadius;

  BehaviorSubject<POIStreamControlBehaviorSubject> get poiController =>
      _poiStreamController;

  //#endregion

  //#region setters

  set poiScrollController(ScrollController value) {
    assert(value != null);
    _poiDraggableScrollableScrollController = value;
  }

  set radius(double value) {
    assert(value != null);
    if (radius != value) {
      _poiFilterByRadius = value;
      if (filter != null) {
        poiController.add(POIStreamControlBehaviorSubject(poiRef, value));
      }
    }
  }

  set filter(BannerType value) {
    assert(value != null);
    if (filter != value) {
      _poiFilterByBannerType = value;
      if (radius != null && radius > 0) {
        poiController.add(POIStreamControlBehaviorSubject(poiRef, radius));
      }
    }
  }

  //#endregion

  //#endregion=

  //#endregion

}

class POIState extends StatefulWidget {
  POIState({@required this.child, @required this.state});
  final Widget child;
  final POIStateData state;

  static POIStateState of(BuildContext context) => (context
          .dependOnInheritedWidgetOfExactType<_InheritedPOIStateContainer>())
      .data;

  @override
  POIStateState createState() => POIStateState(state: state);
}

class POIStateState extends State<POIState> {
  POIStateState({@required this.state});

  POIStateData state;

  @override
  Widget build(BuildContext context) {
    return _InheritedPOIStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedPOIStateContainer extends InheritedWidget {
  _InheritedPOIStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  // Data is the entire POI state
  final POIStateState data;

  // This is a built in method which you can use to check if
  // any state has changed. If not, no reason to rebuild all the widgets
  // that rely on your state.
  @override
  bool updateShouldNotify(_InheritedPOIStateContainer old) => true;
}
