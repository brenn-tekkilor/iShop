// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ishop/data/enums/place_banner.dart';
import 'package:ishop/data/model/geo_radius.dart';
import 'package:ishop/util/enum_parser.dart';

/// PlacesQuerySubject subject of Places Stream Controller
/// Behavior Subject
@immutable
class PlacesQuerySubject {
  /// PlacesQuerySubject default constructor
  const PlacesQuerySubject(FirebaseFirestore firestore,
      {GeoRadius radius = _defaultGeoRadius,
      PlaceBanner banner = _defaultPlaceBanner})
      : _radius = radius,
        _banner = banner,
        _fs = firestore;

  /// PlacesQuerySubject initialized with default Firebase
  /// Firestore instance
  factory PlacesQuerySubject.initial() =>
      PlacesQuerySubject(FirebaseFirestore.instance);
  final GeoRadius _radius;

  /// radius
  GeoRadius get r => _radius;
  final PlaceBanner _banner;

  /// place banner
  PlaceBanner get b => _banner;
  final FirebaseFirestore _fs;
  CollectionReference get _c => _fs.collection(_defaultCollectionName);

  /// Query*
  Query get q => b == PlaceBanner.all
      ? _c
      : _c.where('d.b', isEqualTo: EnumParser.stringValue<PlaceBanner>(b));

  /// Makes a new PlacesQuerySubject instance with identical property
  /// values except with new values passed as args
  PlacesQuerySubject copyWith(
      {GeoRadius? radius, PlaceBanner? banner, FirebaseFirestore? firestore}) {
    final _r = radius ?? r;
    final _b = banner ?? b;
    final _f = firestore ?? _fs;
    return PlacesQuerySubject(_f, radius: _r, banner: _b);
  }

  /// equality operator override
  @override
  bool operator ==(Object? other) =>
      other is PlacesQuerySubject && other.r == r && other.b == b;

  @override
  int get hashCode => r.hashCode ^ b.hashCode;

  static const _defaultGeoRadius = GeoRadius();
  static const _defaultPlaceBanner = PlaceBanner.all;
  static const _defaultCollectionName = 'places';
}
