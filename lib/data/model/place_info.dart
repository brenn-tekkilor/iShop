import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/data/model/place_card_item.dart';
import 'package:ishop/styles.dart';

import 'file:///C:/Users/brenn/source/repos/brenn/ishop/lib/data/model/geo_radius.dart';

@immutable

/// a place summary
class PlaceInfo {
  /// default constructor
  const PlaceInfo(
      {this.id = '',
      this.name = '',
      this.banner = 'foodAndDrug',
      this.latLng = _defaultLatLng});

  /// id
  final String id;

  /// name
  final String name;

  /// banner
  final String banner;

  /// LatLng
  final LatLng latLng;

  /// gets the path of the logo asset
  String get logoPath => banner == 'marketplace'
      ? 'assets/images/marketplacelogo.png'
      : 'assets/images/foodanddruglogo.png';

  /// get the label color
  Color get labelColor => banner == 'marketplace'
      ? AppStyles.primaryTheme.primaryColor.withOpacity(0.8)
      : AppStyles.secondaryColorSwatch.shade500.withOpacity(0.8);

  /// title
  String get title =>
      banner == 'marketplace' ? "Fry's Marketplace" : "Fry's Food & Drug";
  //// pin asset path
  String get pinPath => 'assets/images/destination_map_marker.png';

  /// toPlaceCard
  PlaceCardItem toPlaceCard({Key? key, required int index}) =>
      PlaceCardItem(key: key, index: index, info: this);
  @override
  bool operator ==(Object other) =>
      other is PlaceInfo &&
      other.id.toLowerCase() == id.toLowerCase() &&
      other.name.toLowerCase() == name.toLowerCase() &&
      other.banner.toLowerCase() == banner.toLowerCase() &&
      other.latLng.latitude == latLng.latitude &&
      other.latLng.longitude == latLng.longitude;
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
