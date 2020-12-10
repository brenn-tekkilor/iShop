import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/com/interfaces/fire_doc.dart';
import 'package:ishop/data/enums/place_banner.dart';

@immutable

/// a place summary
abstract class PlaceDetailsDoc extends FireDoc {
  /// default constructor
  const PlaceDetailsDoc();

  /// id
  @override
  String get id;

  /// name
  String get name;

  /// banner
  PlaceBanner get banner;

  /// latLng
  LatLng get latLng;

  /// latitude
  double get latitude;

  /// longitude
  double get longitude;

  /// logo1
  String get logo1;

  /// logo2
  String get logo2;

  /// subtitle
  String get subtitle;

  /// title
  String get title;

  /// color
  Color get color;
}
