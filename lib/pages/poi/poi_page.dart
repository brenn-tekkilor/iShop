import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/pages/poi/poi_banner_filter_toggle.dart';
import 'package:ishop/pages/poi/poi_map.dart';
import 'package:ishop/pages/poi/poi_slider.dart';
import 'package:ishop/utils/util.dart';
import 'package:rxdart/rxdart.dart';

class POIPage extends StatefulWidget {
  @override
  State createState() => POIPageState();
}

class POIPageState extends State<POIPage> {
  final firestore = FirebaseFirestore.instance.collection('maplocationmarkers');
  final geo = Geoflutterfire();
  final markers = <Marker>{};
  final Completer<GoogleMapController> _mapController = Completer();
  LatLng _deviceLocation;
  StreamSubscription<Position> _positionStream;
  Future<StreamSubscription<List<DocumentSnapshot>>> _streamSubscription;
  double _radiusLimit;
  BehaviorSubject<MapEntry<GeoFirePoint, double>> _areaBoundsStream;
  BannerType _bannerType;

  @override
  void initState() {
    super.initState();
    _deviceLocation ??= LatLng(37.7786, -122.4375);
    _radiusLimit ??= 2.0;
    _bannerType ??= BannerType.all;
    _positionStream = getPositionStream(distanceFilter: 10, timeInterval: 5)
        .listen((value) =>
            deviceLocation = LatLng(value.latitude, value.longitude));
    _areaBoundsStream ??=
        BehaviorSubject<MapEntry<GeoFirePoint, double>>.seeded(
            _getQueryAreaBounds());
    _streamSubscription = _getStreamSubscription();
  }

  @override
  void dispose() {
    _positionStream.cancel();
    _streamSubscription = null;
    super.dispose();
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: StreamBuilder<StreamSubscription<List<DocumentSnapshot>>>(
          stream: _streamSubscription.asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData) {
              return Center(child: const Text('Loading...'));
            }
            //#region BannerFilter Listener
            return NotificationListener<BannerFilterNotification>(
                //#region OnDragCompleted Listener
                child: NotificationListener<OnDragCompleted>(
                  //#region OnDragDragging Listener
                  child: NotificationListener<OnDragging>(
                    child: Stack(
                      children: <Widget>[
                        POIMap(
                            markers: markers,
                            initialPosition: deviceLocation,
                            mapController: _mapController),
                        Positioned(
                          bottom: 50,
                          left: 10,
                          child: Container(
                            constraints: BoxConstraints.expand(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                            ),
                            child: POISlider(),
                          ),
                        ),
                        Positioned(
                          top: 50,
                          left: 10,
                          child: POIBannerFilterToggle(),
                        )
                      ],
                    ),
                    onNotification: (dragging) {
                      if (dragging.lowerValue is double &&
                          dragging.lowerValue != _radiusLimit) {
                        radiusLimit = dragging.lowerValue;
                      }
                      return true;
                    },
                  ),
                  //#endregion
                  onNotification: (dragCompleted) {
                    if (dragCompleted.lowerValue is double &&
                        dragCompleted.lowerValue != _radiusLimit) {
                      radiusLimit = dragCompleted.lowerValue;
                    }
                    return true;
                  },
                ),
                //#endregion
                onNotification: (filter) {
                  bannerType = filter.banner;
                  return true;
                });
            //#endregion
          },
        ),
      ),
    );
  }

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
  }

  //#region Firestore stream subscription methods

  Future<StreamSubscription<List<DocumentSnapshot>>>
      _getStreamSubscription() async {
    return await _areaBoundsStream.switchMap((bounds) {
      final ref = _getCollectionQuery();
      return geo.collection(collectionRef: ref).within(
          center: bounds.key,
          radius: bounds.value,
          field: 'point',
          strictMode: false);
    }).listen(_updateMarkers);
  }

  void _updateAreaBounds() {
    setState(() {
      _areaBoundsStream.add(_getQueryAreaBounds());
    });
  }

  //#endregion

  //#region getters/setters

  BannerType get bannerType => _bannerType;

  set bannerType(BannerType value) {
    assert(value != null && value is BannerType);
    if (value != _bannerType) {
      _bannerType = value;
      _streamSubscription = _getStreamSubscription();
    }
  }

  LatLng get deviceLocation => _deviceLocation;

  set deviceLocation(LatLng value) {
    assert(value != null && value is LatLng);
    if (_deviceLocation == null) {
      _deviceLocation = value;
    } else if (_deviceLocation != value) {
      _deviceLocation = value;
      if (geo
              .point(
                  latitude: _deviceLocation.latitude,
                  longitude: _deviceLocation.longitude)
              .distance(lat: value.latitude, lng: value.longitude) >=
          0.000929079 * pow(_radiusLimit, 2) + 2) {
        _updateAreaBounds();
      }
    }
  }

  double get radiusLimit => _radiusLimit;

  set radiusLimit(double value) {
    _radiusLimit = value ?? _radiusLimit ?? 2.0;
    _updateAreaBounds();
  }

  MapEntry<GeoFirePoint, double> _getQueryAreaBounds() {
    return MapEntry<GeoFirePoint, double>(
        _latLngToGeoFirePoint(deviceLocation), radiusLimit);
  }

  dynamic _getCollectionQuery() {
    return _bannerType == BannerType.all
        ? firestore
        : firestore.where('meta.banner',
            isEqualTo: _bannerValueToString(bannerType.toString()));
  }

  Completer get mapController => _mapController;

  //#endregion

  //#region helper methods

  GeoFirePoint _latLngToGeoFirePoint(LatLng value) =>
      geo.point(latitude: value.latitude, longitude: value.longitude);

  String _bannerValueToString(String fullName) {
    return (fullName != null && fullName.isNotEmpty)
        ? fullName.replaceFirst('BannerType.', '')
        : null;
  }

  BannerType _parseBannerType(String value) {
    assert(value != null && value.isNotEmpty);
    return BannerType.values.firstWhere((v) => v.toString() == value);
  }

  LatLng firePointToLatLng(GeoFirePoint value) =>
      LatLng(value.latitude, value.longitude);

  LatLng geoPointToLatLng(GeoPoint value) =>
      LatLng(value.latitude, value.longitude);
//#endregion
}
