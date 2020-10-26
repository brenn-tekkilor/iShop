import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/dev/secrets.dart';

class Parser {
  static T stringToEnum<T>(Iterable<T> values, String stringType) {
    return values.firstWhere(
        (f) =>
            "${f.toString().substring(f.toString().indexOf('.') + 1)}"
                .toString()
                .toLowerCase() ==
            stringType.toLowerCase(),
        orElse: () => null);
  }

  static String enumToString<T>(T value) {
    assert(value != null);
    return value.toString().replaceFirst(RegExp(r"[A-Za-z0-9-_']+?\."), '');
  }

  static LatLng geoPointToLatLng(GeoPoint value) =>
      LatLng(value.latitude, value.longitude);

  static Future<Placemark> posToAddress(Position position) async {
    Placemark result;
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((places) async {
      result = await places[0];
    }).catchError((e) {
      print(e);
    });
    return await result;
  }

  static Future<Location> addressToPos(Placemark address) async {
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

// Create polylines for showing the route between two places
  static Future<Map<PolylineId, Polyline>> posToPolyLines(
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
    return await Map<PolylineId, Polyline>.fromEntries(
        [MapEntry(id, polyline)]);
  }

  static GeoFirePoint latLngToGeoFirePoint(LatLng value) => Geoflutterfire()
      .point(latitude: value.latitude, longitude: value.longitude);

  static LatLng geoFlutterFirePointToLatLng(GeoFirePoint value) =>
      LatLng(value.latitude, value.longitude);

  static LatLng posToLatLng(Position value) =>
      LatLng(value.latitude, value.longitude);
}
