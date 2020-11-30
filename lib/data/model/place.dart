import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/data/enums/place_banner.dart';
import 'package:ishop/data/model/place_address.dart';
import 'package:ishop/util/enum_parser.dart';

/// a Place
class Place {
  //#region ctors
  //#region Place()
  /// default constructor
  const Place(
      {String id = '',
      PlaceAddress address = _defaultAddress,
      String phoneNumber = '',
      double latitude = _defaultLatitude,
      double longitude = _defaultLongitude,
      PlaceBanner banner = _defaultBanner,
      String name = '',
      String hoursOfOperationId = '',
      Set<String> departmentCodeSet = _defaultDepartments})
      : _id = id,
        _address = address,
        _phoneNumber = phoneNumber,
        _latitude = latitude,
        _longitude = longitude,
        _banner = banner,
        _name = name,
        _hoursOfOperationId = hoursOfOperationId,
        _departmentCodeSet = departmentCodeSet;
  //#endregion
  /// constructor from a json map
  factory Place.fromJson(Map<String, dynamic> json) {
    PlaceAddress? a;
    GeoFirePoint? p;
    GeoPoint g;
    double? lat;
    double? lng;
    Set<String>? dep;

    Map<String, dynamic> m;
    dynamic? d;

    d = json.containsKey('c') ? json['c']['a'] : null;
    if (d is Map<String, dynamic>) {
      m = d;
      final _a = PlaceAddress.fromJson(m);
      if (_a is PlaceAddress) {
        a = _a;
      }
    }

    d = json.containsKey('d') ? json['d']['g'] : null;
    if (d is GeoFirePoint) {
      p = d;
      g = p.geoPoint;
      lat = g.latitude;
      lng = g.longitude;
    }

    d = json.containsKey('e') ? json['e']['d'] : null;
    if (d is Set<String>) {
      dep = d;
    }

    return Place(
      id: json['id'].toString(),
      address: a ?? _defaultAddress,
      banner: EnumParser.fromString<PlaceBanner>(
          PlaceBanner.values, json['d']['b'].toString())!,
      hoursOfOperationId: json['e']['h'].toString(),
      latitude: lat ?? _defaultLatitude,
      longitude: lng ?? _defaultLongitude,
      name: json['d']['n'].toString(),
      phoneNumber: json['c']['p'].toString(),
      departmentCodeSet: dep ?? <String>{},
    );
  }

  /// constructor from a firestore document
  factory Place.fromDoc(DocumentSnapshot doc) {
    final data = doc.data();
    final dynamic c = data.containsKey('c') ? data['c'] : _defaultContact;
    final dynamic d = data.containsKey('d') ? data['d'] : _defaultDisplay;
    final dynamic e = data.containsKey('e') ? data['e'] : _defaultExtra;
    return Place.fromJson(<String, dynamic>{
      'id': doc.id,
      'c': c,
      'd': d,
      'e': e,
    });
  }
  //#endregion
  //#region properties
  final String _id;
  final PlaceAddress _address;
  final double _latitude;
  final double _longitude;
  final PlaceBanner _banner;
  final String _name;
  final String _hoursOfOperationId;
  final String _phoneNumber;
  final Set<String> _departmentCodeSet;
  //#endregion
  //#region getters
  /// id
  String get id => _id;

  /// name
  String get name => _name;

  /// address
  PlaceAddress get address => _address;

  /// banner
  PlaceBanner get banner => _banner;

  /// latitude
  double get latitude => _latitude;

  /// longitude
  double get longitude => _longitude;

  /// latLng
  LatLng get latLng => LatLng(_latitude, _longitude);

  /// GeoFirePoint
  GeoFirePoint get geoFirePoint => GeoFirePoint(_latitude, _longitude);

  /// GeoPoint
  GeoPoint get geoPoint => GeoPoint(_latitude, _longitude);

  /// Position
  Position get position => Position(latitude: _latitude, longitude: _longitude);

  /// Location
  Location get location => Location(latitude: _latitude, longitude: _longitude);

  /// PhoneNumber
  String get phoneNumber => _phoneNumber;

  /// Hours of Operation id
  String get hoursOfOperationId => _hoursOfOperationId;

  /// departments
  Set<String> get departmentCodeSet => _departmentCodeSet;

  /// converts Place to be used as a Google Maps Marker
  Marker get marker => Marker(
        markerId: MarkerId(id),
        icon: banner == PlaceBanner.marketplace
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
            : BitmapDescriptor.defaultMarker,
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(
          title: name,
          snippet: banner.toString(),
        ),
      );

  /// converts Place to a json map
  Map<String, dynamic> get json => <String, dynamic>{
        'id': id,
        'c': <String, dynamic>{
          'a': address.json,
          'p': phoneNumber,
        },
        'd': {
          'b': EnumParser.stringValue(banner),
          'g': <String, dynamic>{
            'geohash': geoFirePoint.hash,
            'geopoint': geoFirePoint.geoPoint,
          },
          'n': name,
        },
        'e': <String, dynamic>{
          'd': departmentCodeSet,
          'h': hoursOfOperationId,
        },
      };
  //#endregion
  //#region defaults
  static const _defaultBanner = PlaceBanner.foodAndDrug;
  static const _defaultAddress = PlaceAddress();
  static const _defaultDepartments = <String>{};
  static const _defaultLatitude = 33.646132;
  static const _defaultLongitude = -112.023964;
  static const _defaultContact = <String, dynamic>{
    'a': <String, dynamic>{
      'a1': '',
      'c': 'phoenix',
      's': 'az',
      'u': 'maricopa',
      'z': '',
    },
    'p': ''
  };
  static const _defaultDisplay = <String, dynamic>{
    'b': 'foodAndDrug',
    'g': <String, dynamic>{
      'geohash': '',
      'geopoint': GeoPoint(_defaultLatitude, _defaultLongitude),
    },
    'n': '',
  };
  static const _defaultExtra = <String, dynamic>{
    'd': <String>{},
    'h': '',
  };
  //#endregion
}
