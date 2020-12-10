import 'dart:math';

// ignore: import_of_legacy_library_into_null_safe
import 'package:geolocator/geolocator.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Solver
abstract class Solver {
  /// nearestMultipleInt
  static int nearestMultipleInt(double value, int multiple) {
    final modular = value.round().toInt();
    final m = multiple is int ? multiple : multiple.toInt();
    if (modular == 0 || m == 0) {
      return 0;
    }
    if ((modular % m) == 0.0) {
      return modular;
    }
    // small multiple boundary
    final a = ((modular / m) * m).round().toInt();
    // large multiple boundary
    final b = a + m;
    // result is the closest boundary to value
    return (modular - a > b - modular) ? b : a;
  }

  /// distanceInMeters
  static Future<double> distanceInMeters(Position start, Position end) async =>
      Geolocator.distanceBetween(
          start.latitude, start.longitude, end.latitude, end.longitude);

  /// coordinateDistance
  static double coordinateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const p = 0.017453292519943295;
    const c = cos;
    final a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  /// latLngDistance
  static double latLngDistance(LatLng start, LatLng end) => coordinateDistance(
      start.latitude, start.longitude, end.latitude, end.longitude);

  /// polylineDistance
  static double polylineDistance(Polyline polyline) {
    var result = 0.0;
    // Calculating the total distance by adding the distance
    // between small segments
    for (var i = 0; i < polyline.points.length - 1; i++) {
      result += coordinateDistance(
          polyline.points[i].latitude,
          polyline.points[i].longitude,
          polyline.points[i + 1].latitude,
          polyline.points[i + 1].longitude);
    }
    return result;
  }
}
