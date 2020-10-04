import 'dart:async';
import 'dart:math' show pow;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/utils/map_utils.dart';
import 'package:ishop/utils/util.dart';
import 'package:rxdart/rxdart.dart';

class POISubject {
  const POISubject(this.ref, this.rad);
  final dynamic ref;
  final double rad;
}

class POIState {
  //#region ctor

  POIState()
      : _markers = <Marker>{},
        _poiDocs = FirebaseFirestore.instance.collection('maplocationmarkers'),
        _mapController = Completer(),
        _positionStream = getPositionStream(distanceFilter: 2, timeInterval: 4),
        _filter = BannerType.all,
        _radius = 2.0 {
    _poiController = BehaviorSubject.seeded(POISubject(poiRef, radius));
    _positionSubscription =
        _positionStream.listen((value) => _onStreamedPosition(value));
  }
  //#endregion

  //#region properties
  final CollectionReference _poiDocs;
  final Set<Marker> _markers;
  final Stream<Position> _positionStream;

  //#region variable properties

  BehaviorSubject<POISubject> _poiController;
  LatLng _deviceLocation;
  double _radius;
  final Completer<GoogleMapController> _mapController;
  StreamSubscription<Position> _positionSubscription;
  BannerType _filter;
  Stream<List<DocumentSnapshot>> _poiStream;

  //#endregion

  //#endregion

  //#region methods

  //#region async methods

  Future<POIState> initialize() async {
    _deviceLocation = posToLatLng(await getCurrentPosition());
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
        if (latLngDistance(_deviceLocation, location) >=
            (0.000929079 * pow(radius, 2) + 2)) {
          _deviceLocation = location;
        }
      } else {
        _deviceLocation = location;
      }
    }
  }

  //#endregion

  //#region getters/setters

  //#region getters

  Stream<List<DocumentSnapshot>> get poiStream => _poiStream;

  Set<Marker> get markers => _markers;

  BannerType get filter => _filter;

  dynamic get poiRef => filter == BannerType.all
      ? _poiDocs
      : _poiDocs.where('meta.banner', isEqualTo: enumValue<BannerType>(filter));

  CollectionReference get poiDocs => _poiDocs;

  Completer<GoogleMapController> get mapController => _mapController;

  LatLng get deviceLocation => _deviceLocation;

  StreamSubscription<Position> get positionSubscription =>
      _positionSubscription;

  double get radius => _radius;

  BehaviorSubject<POISubject> get poiController => _poiController;

  //#endregion

  //#region setters

  set radius(double value) {
    assert(value != null);
    if (radius != value) {
      _radius = value;
      if (filter != null) {
        poiController.add(POISubject(poiRef, value));
      }
    }
  }

  set filter(BannerType value) {
    assert(value != null);
    if (filter != value) {
      _filter = value;
      if (radius != null && radius > 0) {
        poiController.add(POISubject(poiRef, radius));
      }
    }
  }

//#endregion

//#endregion=

  //#endregion

}

class POIStateContainer extends StatefulWidget {
  POIStateContainer({@required this.child, @required this.state});
  final Widget child;
  final POIState state;

  static POIStateContainerState of(BuildContext context) => (context
          .dependOnInheritedWidgetOfExactType<_InheritedPOIStateContainer>())
      .data;

  @override
  POIStateContainerState createState() => POIStateContainerState(state: state);
}

class POIStateContainerState extends State<POIStateContainer> {
  POIStateContainerState({@required this.state});

  POIState state;

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
  final POIStateContainerState data;

  // This is a built in method which you can use to check if
  // any state has changed. If not, no reason to rebuild all the widgets
  // that rely on your state.
  @override
  bool updateShouldNotify(_InheritedPOIStateContainer old) => true;
}
