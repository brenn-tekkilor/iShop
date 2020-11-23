import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/app/places/places_provider.dart';
import 'package:ishop/data/model/place_info.dart';
import 'package:ishop/data/service/places_api.dart';
import 'package:provider/provider.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Set<Marker> markers = <Marker>{};

  StreamSubscription<Set<PlaceInfo>>? placeInfoSubscription;
  double pinPosition = -100;
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  PlaceInfo currentlySelectedPin = PlaceInfo();

  void _updateMarkers(Set<PlaceInfo> value) {
    markers.clear();
    markers.addAll(value
        .map((e) => Marker(
            markerId: MarkerId(e.id),
            icon: destinationIcon,
            position: e.latLng,
            onTap: () {
              setState(() {
                currentlySelectedPin = PlaceInfo(
                    id: e.id, name: e.name, banner: e.banner, latLng: e.latLng);
                pinPosition = 0;
              });
            }))
        .toSet());
    setState(() {});
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/driving_pin.png');

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/destination_map_marker.png');
  }

  @override
  void initState() {
    super.initState();
    placeInfoSubscription =
        PlacesAPI.instance().placeInfoStream.listen(_updateMarkers);
    setSourceAndDestinationIcons();
  }

  @override
  void dispose() {
    placeInfoSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceLocation =
        context.select((PlacesProvider p) => p.deviceLocation);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            //#region initialCameraPosition
            initialCameraPosition: CameraPosition(
              target: deviceLocation,
              zoom: 12,
            ),
            //#endregion: :
            //#region markers
            markers: markers,
            //#endregion:
            zoomControlsEnabled: false,
            myLocationButtonEnabled: true,
            compassEnabled: true,
            myLocationEnabled: true,
            trafficEnabled: true,
            onTap: (LatLng location) {
              setState(() {
                pinPosition = -100;
              });
            },
            //#region onMapCreated
            onMapCreated: (mapController) {
              Provider.of<PlacesProvider>(context, listen: false)
                  .placesMapController = mapController;
            },
          ),
          /*
          MapPin(
            pinPosition: pinPosition,
            selectedPin: currentlySelectedPin,
          ),
           */
        ],
      ),
    );
  }
}
