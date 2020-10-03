import 'dart:async';
import 'dart:math' show pow;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/utils/map_utils.dart';
import 'package:ishop/utils/util.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class POIModel extends StatefulWidget with ChangeNotifier {
  @override
  State<StatefulWidget> createState() => POIModelState();
}

class POIModelState extends State<POIModel> with ChangeNotifier {
  //#region constructor

  POIModelState._create()
      : _collection =
            FirebaseFirestore.instance.collection('maplocationmarkers'),
        _markers = <Marker>{},
        _filter = BannerType.all,
        _radius = 2.0,
        _mapController = Completer();

  POIModelState()
      : _collection =
            FirebaseFirestore.instance.collection('maplocationmarkers'),
        _markers = <Marker>{},
        _filter = BannerType.all,
        _radius = 2.0,
        _mapController = Completer();
  //#endregion

  //#region statics

  static POIModelState _instance;

  static Future<POIModelState> getInstance() async {
    if (_instance == null) {
      _instance = POIModelState._create();
      await getCurrentPosition().then((value) async {
        final pos = await value;
        final latLng = posToLatLng(pos);
        _instance._deviceLocation = latLng;
        _instance._broadcast = BehaviorSubject.seeded(_instance.radius);
        _instance._positionStream = getPositionStream(
                distanceFilter: 2, timeInterval: 4)
            .listen((value) => _instance.deviceLocation = posToLatLng(value));
        _instance._stream = await _instance._startStream();
      }).catchError((e) => print(e));
    }
    return _instance;
  }

  static POIModelState of(BuildContext context) =>
      Provider.of<POIModelState>(context, listen: false);

  //#endregion

  //#region properties

  final CollectionReference _collection;
  final _markers;
  final Completer<GoogleMapController> _mapController;
  StreamSubscription<Position> _positionStream;
  BannerType _filter;
  double _radius;
  LatLng _deviceLocation;
  BehaviorSubject<double> _broadcast;
  StreamSubscription<List<DocumentSnapshot>> _stream;

  //#endregion

  //#region methods

  //#region Firestore stream subscription methods

  Future<StreamSubscription<List<DocumentSnapshot>>> _startStream() async {
    return await _broadcast.switchMap((rad) {
      return geo
          .collection(
              collectionRef: _filter == BannerType.all
                  ? _collection
                  : _collection.where('meta.banner',
                      isEqualTo: bannerValueToString(filter.toString())))
          .within(
              center: latLngToGeoFirePoint(deviceLocation),
              radius: rad,
              field: 'point',
              strictMode: false);
    }).listen(_updateMarkers);
  }

  void _updateStream() async {
    _stream = await _startStream();
  }

  void _updateBroadcast() {
    _broadcast.add(radius);
  }
  //#endregion

  //#region POI Map Markers mgmnt

  void _addMarker(Marker value) {
    assert(value != null);
    if (!markers.contains(value)) {
      markers.removeWhere((e) => e.markerId.value == value.markerId.value);
      markers.add(value);
    }
  }

  void _updateMarkers(List<DocumentSnapshot> docList) {
    markers.clear();
    docList.forEach((d) {
      final data = d.data();
      final banner = data['meta']['banner'];
      final point = data['point']['geopoint'];
      _addMarker(Marker(
        markerId: MarkerId(d.id),
        position: geoPointToLatLng(point),
        icon: banner == 'marketplace'
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
            : BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: data['name'],
          snippet: banner,
        ),
      ));
    });
    notifyListeners();
  }

  //#endregion

  //#region getters/setters

  //#region getters
  BehaviorSubject<double> get broadcast => _broadcast;

  Completer<GoogleMapController> get mapController => _mapController;

  StreamSubscription<List<DocumentSnapshot>> get stream => _stream;

  BannerType get filter => _filter;

  LatLng get deviceLocation => _deviceLocation;

  double get radius => _radius;

  Set<Marker> get markers => _markers;

  CollectionReference get collection => _collection;

  StreamSubscription<Position> get positionStream => _positionStream;

  //#endregion

  //#region setters

  set filter(BannerType value) {
    assert(value != null);
    if (filter != value) {
      _filter = value;
      _updateStream();
    }
  }

  set deviceLocation(LatLng value) {
    assert(value != null);
    if (_deviceLocation != value) {
      if (latLngDistance(_deviceLocation, value) >=
          0.000929079 * pow(radius, 2) + 2) {
        _updateBroadcastLocation(value);
      }
      _deviceLocation = value;
    }
  }

  void _updateBroadcastLocation(LatLng location) {
    _deviceLocation = location;
    _updateBroadcast();
  }

  set radius(double value) {
    assert(value != null);
    if (radius != value) {
      _radius = value;
      _updateBroadcast();
    }
  }

  //#endregion

  //#endregion

  //#endregion

  //#region overrides
  @override
  Widget build(BuildContext context) => Container(width: 0.0, height: 0.0);
  //#endregion
}

class POIProvider extends StatefulWidget with ChangeNotifier {
  POIProvider({@required this.model});

  final POIModelState model;
  static POIProvider of(BuildContext context, bool listen) =>
      Provider.of<POIProvider>(context, listen: listen);
  @override
  _POIProviderState createState() => _POIProviderState(model: model);
}

class _POIProviderState extends State<POIProvider> with ChangeNotifier {
  _POIProviderState({@required this.model});

  final POIModelState model;
  @override
  Widget build(BuildContext context) => Container(width: 0.0, height: 0.0);
}
