import 'dart:math' show asin, cos, sqrt;

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/secrets.dart';

Future<Placemark> getAddressFromPosition(Position position) async {
  Placemark result;
  await placemarkFromCoordinates(position.latitude, position.longitude)
      .then((places) async {
    result = await places[0];
  }).catchError((e) {
    print(e);
  });
  return await result;
}

Future<Location> getPositionFromAddress(Placemark address) async {
  Location result;
  await locationFromAddress(
          '${address.name}, ${address.locality}, ${address.postalCode}, ${address.country}')
      .then((addresses) async {
    result = await addresses[0];
  }).catchError((e) {
    print(e);
  });
  return await result;
}

Future<double> distanceInMeters(Position start, Position end) async {
  return await distanceBetween(
      start.latitude, start.longitude, end.latitude, end.longitude);
}

double _coordinateDistance(double lat1, double lon1, double lat2, double lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}

double polylineDistance(Polyline polyline) {
  var result = 0.0;
  // Calculating the total distance by adding the distance
  // between small segments
  for (var i = 0; i < polyline.points.length - 1; i++) {
    result += _coordinateDistance(
        polyline.points[i].latitude,
        polyline.points[i].longitude,
        polyline.points[i + 1].latitude,
        polyline.points[i + 1].longitude);
  }
  return result;
}

// Create polylines for showing the route between two places
Future<Map<PolylineId, Polyline>> createPolylines(
    Position start, Position end) async {
  // List of coordinates to join
  var polylineCoordinates = <LatLng>[];

  // Generating the list of coordinates to be used for
  // drawing the polylines
  var polylinePoints = await PolylinePoints().getRouteBetweenCoordinates(
    Secrets.androidGoogleMapsAPIKey, // Google Maps API Key
    PointLatLng(start.latitude, start.longitude),
    PointLatLng(end.latitude, end.longitude),
    travelMode: TravelMode.transit,
  );

  // Adding the coordinates to the list
  if (polylinePoints.points.isNotEmpty) {
    polylinePoints.points.forEach((PointLatLng point) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    });
  }
  var id = PolylineId('poly');
  // Initializing Polyline
  var polyline = Polyline(
    polylineId: id,
    color: Colors.red,
    points: polylineCoordinates,
    width: 3,
  );
  // Adding the polyline to the map
  return await Map<PolylineId, Polyline>.fromEntries([MapEntry(id, polyline)]);
}
