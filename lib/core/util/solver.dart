import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Solver {
  static int nearestMultipleInt(double value, int multiple) {
    assert(value != null && multiple != null);
    final modular = value.round().toInt();
    multiple = multiple is int ? multiple : multiple.toInt();
    if (modular == 0 || multiple == 0) {
      return 0;
    }
    if ((modular % multiple) == 0.0) {
      return modular;
    }
    // small multiple boundary
    final a = ((modular / multiple) * multiple).round().toInt();
    // large multiple boundary
    final b = a + multiple;
    // result is the closest boundary to value
    return (modular - a > b - modular) ? b : a;
  }

  static double kilometerToMiles(double value) => value * 0.621371;

  static Future<double> distanceInMeters(Position start, Position end) async {
    return await distanceBetween(
        start.latitude, start.longitude, end.latitude, end.longitude);
  }

  static double coordinateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static double latLngDistance(LatLng start, LatLng end) =>
      (start != null && end != null)
          ? coordinateDistance(
              start.latitude, start.longitude, end.latitude, end.longitude)
          : -1.0;

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
