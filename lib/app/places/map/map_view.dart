import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/app/places/places_provider.dart';
import 'package:ishop/data/model/place_info.dart';
import 'package:provider/provider.dart';

/// MapView
class MapView extends StatefulWidget {
  /// MapView default const constructor
  const MapView({Key? key}) : super(key: key);
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  /// markers
  final Set<Marker> _markers = <Marker>{};

  /// placeInfoSubscription
  StreamSubscription<List<PlaceInfo>>? _placeInfoSubscription;

  /// pinPosition
  double _pinPosition = -100;

  ///sourceIcon
  BitmapDescriptor _sourceIcon = BitmapDescriptor.defaultMarker;

  ///destinationIcon
  BitmapDescriptor _destinationIcon = BitmapDescriptor.defaultMarker;

  ///currentlySelectedPin
  PlaceInfo _currentlySelectedPin = const PlaceInfo();
  void _updateMarkers(List<PlaceInfo> value) {
    _markers
      ..clear()
      ..addAll(value
          .map((e) => Marker(
              markerId: MarkerId(e.id),
              icon: _destinationIcon,
              position: e.latLng,
              onTap: () {
                setState(() {
                  _currentlySelectedPin = PlaceInfo(
                      id: e.id,
                      name: e.name,
                      banner: e.banner,
                      latLng: e.latLng);
                  _pinPosition = 0;
                });
              }))
          .toSet());
    setState(() {});
  }

  Future<void> _setSourceAndDestinationIcons() async {
    _sourceIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/driving_pin.png');

    _destinationIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/destination_map_marker.png');
  }

  @override
  void initState() {
    super.initState();
    _setSourceAndDestinationIcons();
    _placeInfoSubscription = Provider.of<PlacesProvider>(context, listen: false)
        .places
        .listen(_updateMarkers);
  }

  @override
  void dispose() {
    if (_placeInfoSubscription != null) {
      _placeInfoSubscription?.cancel();
      _placeInfoSubscription = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              //#region initialCameraPosition
              initialCameraPosition: CameraPosition(
                target: Provider.of<PlacesProvider>(context, listen: false)
                    .deviceLocation,
                zoom: 12,
              ),
              //#endregion: :
              //#region markers
              markers: _markers,
              //#endregion:
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              trafficEnabled: true,
              onTap: (location) {
                setState(() {
                  _pinPosition = -100;
                });
              },
              //#region onMapCreated
              onMapCreated: (controller) {
                Provider.of<PlacesProvider>(context, listen: false)
                    .mapController = controller;
              },
            ),
          ],
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<Marker>('markers', _markers))
      ..add(DiagnosticsProperty<StreamSubscription<List<PlaceInfo>>>(
          'placeInfoSubscription', _placeInfoSubscription))
      ..add(DiagnosticsProperty<BitmapDescriptor>('sourceIcon', _sourceIcon))
      ..add(DiagnosticsProperty<double>('pinPosition', _pinPosition))
      ..add(DiagnosticsProperty<PlaceInfo>(
          'currentlySelectedPin', _currentlySelectedPin))
      ..add(DiagnosticsProperty<BitmapDescriptor>(
          'destinationIcon', _destinationIcon));
  }
}
