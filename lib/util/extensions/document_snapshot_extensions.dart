import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/styles.dart';
import 'package:ishop/util/extensions/latitude_longitude_adapter.dart';

extension DocumentSnapshotToMarker on DocumentSnapshot {
  Marker toMarker() {
    final d = data()['d'];
    final b = d['b'];
    final _id = id;
    return Marker(
      markerId: MarkerId(_id),
      position: (d['g']['geopoint'] as GeoPoint).to<LatLng>(),
      infoWindow: InfoWindow(
        title: d['n'],
        snippet: b,
      ),
      icon: b == 'marketplace'
          ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
          : BitmapDescriptor.defaultMarker,
    );
  }
}

extension DocumentSnapshotToCard on DocumentSnapshot {
  Card toCard() {
    final d = data()['d'];
    return Card(
      key: ValueKey(id),
      color: d['b'] == 'marketplace'
          ? Colors.greenAccent.withOpacity(0.8)
          : Colors.cyanAccent.withOpacity(0.8),
      child: Flexible(
        child: Expanded(
          child: Text(
            d['n'],
            style: AppStyles.primaryTheme.typography.black.headline5,
          ),
        ),
      ),
    );
  }
}
