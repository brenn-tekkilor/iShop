// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/data/enums/place_banner.dart';
import 'package:ishop/data/model/geo_radius.dart' show GeoRadius;
import 'package:ishop/data/model/place_details.dart';
import 'package:ishop/util/enum_parser.dart';
import 'package:ishop/util/extensions/json_extensions.dart';

/// document snapshot extensions
extension DocumentSnapshotExtensions on DocumentSnapshot {
  /// to place info
  PlaceDetails get placeDetails => PlaceDetails(
        id: id,
        name: _name,
        banner: banner ?? PlaceBanner.foodAndDrug,
        latLng: LatLng(latitude, longitude),
      );
  Map<String, dynamic> get _details {
    if (data().containsKey('d')) {
      final dynamic d = data()['d'];
      if (d is Map<String, dynamic>) {
        return d;
      }
    }
    return <String, dynamic>{};
  }

  GeoPoint? get _geoPoint {
    final dynamic g = _details.traverse(keys: ['g', 'geopoint']);
    return g is GeoPoint ? g : null;
  }

  /// latitude
  double get latitude => _geoPoint?.latitude ?? _defaultLatitude;

  /// longitude
  double get longitude => _geoPoint?.longitude ?? _defaultLongitude;
  double get _defaultLatitude => GeoRadius.defaultLatitude;
  double get _defaultLongitude => GeoRadius.defaultLongitude;

  /// banner
  PlaceBanner? get banner =>
      EnumParser.fromString(PlaceBanner.values, _details['b'].toString());
  String get _name => _details['n'].toString();
}
