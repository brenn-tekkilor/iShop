import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/data/service/geo_radius.dart';
import 'package:ishop/styles.dart';

class PlaceInfo {
  const PlaceInfo(
      {String id = '',
      String name = '',
      String banner = 'foodAndDrug',
      latLng = _defaultLatLng})
      : id = id,
        name = name,
        banner = banner,
        latLng = latLng;

  final String id;
  final String name;
  final String banner;
  final LatLng latLng;
  String get logoPath => banner == 'marketplace'
      ? 'assets/images/marketplacelogo.png'
      : 'assets/images/foodanddruglogo.png';
  Color get labelColor => banner == 'marketplace'
      ? AppStyles.primaryTheme.primaryColor.withOpacity(0.8)
      : AppStyles.secondaryColorSwatch.shade500.withOpacity(0.8);
  String get title =>
      banner == 'marketplace' ? "Fry's Marketplace" : "Fry's Food & Drug";
  String get pinPath => 'assets/images/destination_map_marker.png';
  @override
  bool operator ==(Object other) => (other is PlaceInfo &&
          other.id.toLowerCase() == id.toLowerCase() &&
          other.name.toLowerCase() == name.toLowerCase() &&
          other.banner.toLowerCase() == banner.toLowerCase() &&
          other.latLng.latitude == latLng.latitude &&
          other.latLng.longitude == latLng.longitude)
      ? true
      : false;
  @override
  int get hashCode =>
      id.toLowerCase().hashCode ^
      name.toLowerCase().hashCode ^
      banner.toLowerCase().hashCode ^
      latLng.latitude.hashCode ^
      latLng.longitude.hashCode;

  static const _defaultLatLng =
      LatLng(GeoRadius.defaultLatitude, GeoRadius.defaultLongitude);
}
