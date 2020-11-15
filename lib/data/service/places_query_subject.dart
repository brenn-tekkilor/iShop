import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ishop/data/enums/place_banner.dart';
import 'package:ishop/data/service/geo_radius.dart';
import 'package:ishop/util/enum_parser.dart';

class PlacesQuerySubject {
  const PlacesQuerySubject(FirebaseFirestore firestore,
      {GeoRadius radius = _defaultGeoRadius,
      PlaceBanner banner = _defaultPlaceBanner})
      : _radius = radius,
        _banner = banner,
        _fs = firestore;

  factory PlacesQuerySubject.initial() {
    return PlacesQuerySubject(FirebaseFirestore.instance);
  }

  final GeoRadius _radius;
  GeoRadius get r => _radius;
  final PlaceBanner _banner;
  PlaceBanner get b => _banner;
  final FirebaseFirestore _fs;
  CollectionReference get _c => _fs.collection(_defaultCollectionName);
  dynamic get q => b == PlaceBanner.all
      ? _c
      : _c.where('d.b', isEqualTo: EnumParser.stringValue<PlaceBanner>(b));
  PlacesQuerySubject copyWith(
      {GeoRadius? radius, PlaceBanner? banner, FirebaseFirestore? firestore}) {
    final _r = radius ?? r;
    final _b = banner ?? b;
    final _f = firestore ?? _fs;
    return PlacesQuerySubject(_f, radius: _r, banner: _b);
  }

  @override
  bool operator ==(Object? other) =>
      (other is PlacesQuerySubject && other.r == r && other.b == b)
          ? true
          : false;

  @override
  int get hashCode => r.hashCode ^ b.hashCode;

  static const _defaultGeoRadius = GeoRadius();
  static const _defaultPlaceBanner = PlaceBanner.all;
  static const _defaultCollectionName = 'places';
}
