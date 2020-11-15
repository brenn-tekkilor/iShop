import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Parser {
  static GeoFirePoint latLngToGeoFirePoint(LatLng value) => Geoflutterfire()
      .point(latitude: value.latitude, longitude: value.longitude);

  static LatLng geoFlutterFirePointToLatLng(GeoFirePoint value) =>
      LatLng(value.latitude, value.longitude);

  static LatLng posToLatLng(Position value) =>
      LatLng(value.latitude, value.longitude);
}
