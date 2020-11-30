import 'package:flutter/cupertino.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

@immutable

/// GeoRadius
class GeoRadius {
  /// default const GeoRadius constructor
  const GeoRadius(
      {double latitude = defaultLatitude,
      double longitude = defaultLongitude,
      double radius = defaultRadius})
      : _latitude = latitude,
        _longitude = longitude,
        _radius = radius;

  final double _latitude;

  /// latitude
  double get latitude => _latitude;
  final double _longitude;

  /// longitude
  double get longitude => _longitude;
  final double _radius;

  /// radius
  double get r => _radius;

  /// center focus
  GeoFirePoint get c => GeoFirePoint(latitude, longitude);

  /// copy with
  GeoRadius copyWith({double? lat, double? lng, double? rad}) {
    final _lat = lat ?? latitude;
    final _lng = lng ?? longitude;
    final _rad = rad ?? r;
    return GeoRadius(latitude: _lat, longitude: _lng, radius: _rad);
  }

  @override
  bool operator ==(Object? other) =>
      other is GeoRadius &&
      other.latitude == latitude &&
      other.longitude == longitude &&
      other.r == r;
  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode ^ r.hashCode;

  /// default radius
  static const defaultRadius = 4.0;

  /// default latitude
  static const defaultLatitude = 33.646132;

  /// default longitude
  static const defaultLongitude = -112.023964;
}
