import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/pages/locations/locations_list_scroll.dart';
import 'package:ishop/utils/util.dart';

class LocationsMapPage extends StatefulWidget {
  @override
  _LocationsMapPageState createState() => _LocationsMapPageState();
}

class _LocationsMapPageState extends State<LocationsMapPage> {
  _LocationsMapPageState() {
    _positionStream = getPositionStream(distanceFilter: 10, timeInterval: 10)
        .listen((value) =>
            currentPosition = LatLng(value.latitude, value.longitude));
  }

  //# region final members

  final _mapMarkers = <Marker>{};

  final _visibleMarkers = <Marker>{};

  //#endregion

  //#region private members

  CameraPosition _initialPosition;

  String _deviceName;

  StreamSubscription<Position> _positionStream;

  GoogleMapController _mapController;

  LatLng _currentPosition;

  int filterValue;
  //#endregion

  //#region helpers
  void _filterMapMarkers(int value) {
    _visibleMarkers.clear();
    switch (value) {
      case 1:
        {
          _mapMarkers
              .where((e) => e.infoWindow.snippet == 'marketplace')
              .forEach((m) => _visibleMarkers.add(m));
        }
        break;
      case 2:
        {
          _mapMarkers
              .where((e) => e.infoWindow.snippet == 'foodAndDrug')
              .forEach((m) => _visibleMarkers.add(m));
        }
        break;
      default:
        {
          _mapMarkers.forEach((m) => _visibleMarkers.add(m));
        }
        break;
    }
    filterValue = value;
  }

  void _removeMapMarker(String id) {
    assert(id != null);
    _visibleMarkers
        .where((e) => e.markerId.value == id)
        .forEach((m) => _visibleMarkers.remove(m));
    _mapMarkers
        .where((e) => e.markerId.value == id)
        .forEach((m) => _mapMarkers.remove(m));
  }

  void _reposition(LatLng position) {
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 18.0),
      ),
    );
  }

  void _recenter() {
    _reposition(currentPosition ?? _initialPosition.target);
  }

  void _addMapMarker(Marker value) {
    _removeMapMarker(value.markerId.value);
    _mapMarkers.add(value);
    _visibleMarkers.add(value);
  }

  void _addMapMarkerFromDoc(DocumentSnapshot doc) {
    final id = doc.id;
    final data = doc.data();
    final name = data['name'];
    final geopoint = data['point']['geopoint'];
    final latLng = LatLng(geopoint.latitude, geopoint.longitude);
    final banner = data['meta']['banner'];
    final icon = banner == 'marketplace'
        ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
        : BitmapDescriptor.defaultMarker;
    final infoWindow = InfoWindow(title: name, snippet: banner);
    final marker = Marker(
      markerId: MarkerId(id),
      position: latLng,
      icon: icon ?? BitmapDescriptor.defaultMarker,
      infoWindow: infoWindow,
    );
    _addMapMarker(marker);
  }

  //#endregion

  //#region getters/setters

  Marker get deviceMarker => _mapMarkers
      .firstWhere((element) => element.markerId.value == _deviceName);

  LatLng get currentPosition => _currentPosition;

  set currentPosition(LatLng value) {
    assert(value != null);
    _currentPosition = value;
    final marker = Marker(
      markerId: MarkerId(_deviceName),
      position: _currentPosition,
      infoWindow: InfoWindow(
        title: _deviceName,
      ),
    );
    _addMapMarker(marker);
  }
  //#endregion

  Future<bool> _initializeMap() async {
    if (_deviceName == null) {
      final deviceInfoPlugin = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final deviceInfo = await deviceInfoPlugin.androidInfo;
        _deviceName = deviceInfo.model;
      } else if (Platform.isIOS) {
        final deviceInfo = await deviceInfoPlugin.iosInfo;
        _deviceName = deviceInfo.utsname.machine;
      } else {
        _deviceName = Platform.localHostname ?? 'Current Device';
      }
    }
    if (currentPosition == null) {
      final position = await getCurrentPosition();
      currentPosition = LatLng(position.latitude, position.longitude);
    }
    if (_mapMarkers.length < 70) {
      await FirebaseFirestore.instance
          .collection('maplocationmarkers')
          .get()
          .then(
              (markers) => markers.docs.forEach((d) => _addMapMarkerFromDoc(d)))
          .catchError((e) => print(e));
    }
    _initialPosition = CameraPosition(target: currentPosition, zoom: 10);
    return true;
  }

  //#endregion

  //#region builders

  Widget _myLocationButton() {
    return Positioned(
      bottom: 100,
      right: 10,
      child: FlatButton(
        child: Icon(Icons.pin_drop),
        color: Colors.green,
        onPressed: _recenter,
      ),
    );
  }

  //#endregion

  @override
  void dispose() {
    _positionStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return FutureBuilder<bool>(
        future: _initializeMap(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong: ${snapshot.error.toString()}');
          }
          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return Text('Loading');
          }
          return Container(
            height: height,
            width: width,
            child: Scaffold(
              key: _scaffoldKey,
              body: Stack(
                children: <Widget>[
                  // Map View
                  GoogleMap(
                    markers: _visibleMarkers,
                    initialCameraPosition: _initialPosition,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    mapType: MapType.normal,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: false,
                    onMapCreated: (controller) {
                      _mapController = controller;
                    },
                    // polylines: Set<Polyline>.of(polylines.values),
                  ),
                  _myLocationButton(),
                  Builder(builder: (BuildContext context) {
                    return NotificationListener<FilterActionNotification>(
                      child: LocationsListScroll(filterValue),
                      onNotification: (notification) {
                        _filterMapMarkers(notification.value);
                        return true;
                      },
                    );
                  }),
                ],
              ),
            ),
          );
        });
  }
}
