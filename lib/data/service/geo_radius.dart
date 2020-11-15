import 'package:geoflutterfire/geoflutterfire.dart';

class GeoRadius {
  const GeoRadius(
      {double latitude = defaultLatitude,
      double longitude = defaultLongitude,
      double radius = defaultRadius})
      : _latitude = latitude,
        _longitude = longitude,
        _radius = radius;

  final double _latitude;
  double get latitude => _latitude;
  final double _longitude;
  double get longitude => _longitude;
  final double _radius;
  double get r => _radius;
  GeoFirePoint get c => GeoFirePoint(latitude, longitude);
  GeoRadius copyWith({double? lat, double? lng, double? rad}) {
    final _lat = lat ?? latitude;
    final _lng = lng ?? longitude;
    final _rad = rad ?? r;
    return GeoRadius(latitude: _lat, longitude: _lng, radius: _rad);
  }

  @override
  bool operator ==(Object? other) => (other is GeoRadius &&
          other.latitude == latitude &&
          other.longitude == longitude &&
          other.r == r)
      ? true
      : false;
  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode ^ r.hashCode;
  static const defaultRadius = 4.0;
  static const defaultLatitude = 33.646132;
  static const defaultLongitude = -112.023964;
}
