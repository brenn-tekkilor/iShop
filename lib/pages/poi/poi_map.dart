import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/pages/poi/poi_state.dart';
import 'package:ishop/utils/map_utils.dart';

class POIMap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _POIMapState();
}

class _POIMapState extends State<POIMap> {
  //#region properties
  final _markers = <Marker>{};
  LatLng _deviceLocation;
  LocationData _data;
  StreamSubscription<List<DocumentSnapshot>> _subscription;
  ScrollController _poiScrollController;
  //#endregion

  //#region poiMap marker methods

  void _addMarker(Marker value) {
    assert(value != null);
    if (!_markers.contains(value)) {
      _markers.removeWhere((e) => e.markerId.value == value.markerId.value);
      _markers.add(value);
    }
  }

  Marker _docToMarker(DocumentSnapshot doc, int index) {
    final data = doc.data();
    final banner = data['meta']['banner'];
    final point = data['point']['geopoint'];
    final markerId = MarkerId(doc.id);
    return Marker(
        markerId: markerId,
        position: geoPointToLatLng(point),
        icon: banner == 'marketplace'
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
            : BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: data['name'],
          snippet: banner,
        ),
        onTap: () async {
          final scrollControl = _data.poiScrollController;
          if (scrollControl != null) {
            scrollControl.jumpTo(0.0);
            scrollControl.jumpTo(100.0);
            await scrollControl.animateTo(140 + 60.0 * index,
                duration: Duration(milliseconds: 800), curve: Curves.easeInOut);
          }
          await _data.showMapMarkerInfo(markerId);
        });
  }

  void _updateMarkers(List<DocumentSnapshot> docs) {
    _markers.clear();
    _poiScrollController ??= _data.poiScrollController;
    docs.forEach((e) => _addMarker(_docToMarker(e, docs.indexOf(e))));
    setState(() {});
  }

  //#endregion

  @override
  Widget build(BuildContext context) {
    _data ??= LocationDataProvider.of(context).locationData;
    _subscription ??= _data.poiStream.listen(_updateMarkers);
    _deviceLocation ??= _data.deviceLocation;
    _poiScrollController ??= _data.poiScrollController;
    //#region GoogleMap
    return GoogleMap(
      //#region initialCameraPosition
      initialCameraPosition: CameraPosition(
        target: _deviceLocation,
        zoom: 12,
      ),
      //#endregion
      //#region markers
      markers: _markers,
      //#endregion
      zoomControlsEnabled: false,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      trafficEnabled: true,
      //#region onMapCreated
      onMapCreated: (mapController) {
        _data.mapController = mapController;
      },
      //#endregion
    );
    //#endregion
  }
}
