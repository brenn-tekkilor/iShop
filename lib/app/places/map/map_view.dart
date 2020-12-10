import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/app/places/places_provider.dart';
import 'package:ishop/data/enums/place_banner.dart';
import 'package:ishop/data/model/place_details.dart';
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
  StreamSubscription<List<PlaceDetails>>? _places;

  ///sourceIcon
  BitmapDescriptor _foodAndDrugPin = BitmapDescriptor.defaultMarker;

  ///destinationIcon
  BitmapDescriptor _marketplacePin = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    super.initState();
    _setSourceAndDestinationIcons();
    _places = Provider.of<PlacesProvider>(context, listen: false)
        .places
        .listen(_updateMarkers);
  }

  void _updateMarkers(List<PlaceDetails> value) {
    _markers
      ..clear()
      ..addAll(value
          .map((e) => Marker(
              markerId: MarkerId(e.id),
              icon: e.banner == PlaceBanner.marketplace
                  ? _marketplacePin
                  : _foodAndDrugPin,
              position: e.latLng,
              consumeTapEvents: true,
              onTap: () {
                Provider.of<PlacesProvider>(context, listen: false)
                    .selectedPlace = e;
              }))
          .toSet());
    setState(() {});
  }

  Future<void> _setSourceAndDestinationIcons() async {
    _foodAndDrugPin = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/foodanddrugpin.png');

    _marketplacePin = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/marketplace_pin.png');
  }

  @override
  void dispose() {
    if (_places != null) {
      _places?.cancel();
      _places = null;
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
              markers: _markers,
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              trafficEnabled: true,
              onTap: (_) => {
                Provider.of<PlacesProvider>(context, listen: false)
                    .selectedPlace = null
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
      ..add(DiagnosticsProperty<StreamSubscription<List<PlaceDetails>>>(
          'placeInfoSubscription', _places))
      ..add(DiagnosticsProperty<BitmapDescriptor>(
          '_foodAndDrugPin', _foodAndDrugPin))
      ..add(DiagnosticsProperty<BitmapDescriptor>(
          '_marketplacePin', _marketplacePin));
  }
}
