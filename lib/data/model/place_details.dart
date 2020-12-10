import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/app_styles.dart';
import 'package:ishop/com/interfaces/place_details_doc.dart';
import 'package:ishop/data/enums/place_banner.dart';
import 'package:ishop/data/model/geo_radius.dart';

@immutable

/// a place summary
class PlaceDetails extends PlaceDetailsDoc {
  /// default constructor
  const PlaceDetails(
      {required String id,
      String name = '',
      PlaceBanner banner = PlaceBanner.foodAndDrug,
      LatLng latLng = _defaultLatLng})
      : _id = id,
        _name = name,
        _banner = banner,
        _latLng = latLng;

  final String _id;
  final String _name;
  final PlaceBanner _banner;
  final LatLng _latLng;
  @override
  String get id => _id;
  @override
  String get name => _name;
  @override
  PlaceBanner get banner => _banner;
  @override
  LatLng get latLng => _latLng;
  @override
  double get latitude => latLng.latitude;
  @override
  double get longitude => latLng.longitude;
  @override
  String get logo1 => banner == PlaceBanner.marketplace
      ? 'assets/logos/frys_marketplace_logo_1.png'
      : 'assets/logos/frys_food_logo_1.png';
  @override
  String get logo2 => banner == PlaceBanner.marketplace
      ? 'assets/logos/frys_marketplace_logo_2.png'
      : 'assets/logos/frys_food_logo_2.png';
  @override
  String get subtitle => name;
  @override
  String get title => banner == PlaceBanner.marketplace
      ? "Fry's Marketplace"
      : "Fry's Food & Drug";
  @override
  Color get color => banner == PlaceBanner.marketplace
      ? primaryColor.withOpacity(0.8)
      : secondaryColorSwatch.shade500.withOpacity(0.8);
  @override
  bool operator ==(Object other) =>
      other is PlaceDetails &&
      other.id.toLowerCase() == id.toLowerCase() &&
      other.name.toLowerCase() == name.toLowerCase() &&
      other.banner == banner &&
      other.latLng.latitude == latLng.latitude &&
      other.latLng.longitude == latLng.longitude;
  @override
  int get hashCode =>
      id.toLowerCase().hashCode ^
      name.toLowerCase().hashCode ^
      banner.hashCode ^
      latLng.latitude.hashCode ^
      latLng.longitude.hashCode;
  static const _defaultLatLng =
      LatLng(GeoRadius.defaultLatitude, GeoRadius.defaultLongitude);
}
