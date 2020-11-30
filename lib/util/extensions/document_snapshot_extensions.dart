import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/data/model/geo_radius.dart';
import 'package:ishop/data/model/place_info.dart';
import 'package:ishop/util/extensions/json_extensions.dart';
import 'package:ishop/util/extensions/latitude_longitude_adapter.dart';

/// document snapshot extensions
extension DocumentSnapshotExtensions on DocumentSnapshot {
  /// to place info
  PlaceInfo get placeInfo {
    final dynamic d =
        data().containsKey('d') ? data()['d'] : <String, dynamic>{};
    final m = d is Map<String, dynamic> ? d : <String, dynamic>{};
    final dynamic g = m.traverse(keys: ['g', 'geopoint']);
    final p = g is GeoPoint ? g : null;
    const dl = LatLng(GeoRadius.defaultLatitude, GeoRadius.defaultLongitude);
    final l = p != null ? p.to<LatLng>() ?? dl : dl;
    return PlaceInfo(
      id: id,
      name: m['n'].toString(),
      banner: m['b'].toString(),
      latLng: l,
    );
  }

  /// to GeoFirePoint
  GeoFirePoint? get geoFirePoint {
    final dynamic d = data().traverse(keys: ['d', 'g']);
    return d is GeoFirePoint ? d : null;
  }

  /// Haversine Distance
  double haversineDistance(
      {required double latitude, required double longitude}) {
    final g = geoFirePoint;
    final dynamic d = g?.haversineDistance(lat: latitude, lng: longitude);
    return d is double ? d : double.nan;
  }

  /// banner
  String get banner {
    final dynamic d = data().traverse(keys: ['d', 'b']);
    return d is String ? d : '';
  }
}
