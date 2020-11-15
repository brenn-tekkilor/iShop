import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/data/enums/place_banner.dart';
import 'package:ishop/data/model/place_address.dart';
import 'package:ishop/util/enum_parser.dart';

class Place {
  //#region ctors
  //#region Place()
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
  factory Place.fromJson(Map<String, dynamic> json) => Place(
        id: json['id'],
        address: PlaceAddress.fromJson(json['c']['a']),
        banner: EnumParser.fromString<PlaceBanner>(
            PlaceBanner.values, json['d']['b'])!,
        hoursOfOperationId: json['e']['h'],
        latitude: (json['d']['g'] as GeoFirePoint).geoPoint?.latitude as double,
        longitude:
            (json['d']['g'] as GeoFirePoint).geoPoint?.longitude as double,
        name: json['d']['n'],
        phoneNumber: json['c']['p'],
        departmentCodeSet: json['e']['d'] as Set<String>,
      );
  factory Place.fromDoc(DocumentSnapshot doc) {
    final data = doc.data();
    final c = data.containsKey('c') ? data['c'] : _defaultContact;
    final d = data.containsKey('d') ? data['d'] : _defaultDisplay;
    final e = data.containsKey('e') ? data['e'] : _defaultExtra;
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
  String get id => _id;
  String get name => _name;
  PlaceAddress get address => _address;
  PlaceBanner get banner => _banner;
  double get latitude => _latitude;
  double get longitude => _longitude;
  LatLng get latLng => LatLng(_latitude, _longitude);
  GeoFirePoint get geoFirePoint => GeoFirePoint(_latitude, _longitude);
  GeoPoint get geoPoint => GeoPoint(_latitude, _longitude);
  Position get position => Position(latitude: _latitude, longitude: _longitude);
  Location get location => Location(latitude: _latitude, longitude: _longitude);
  String get phoneNumber => _phoneNumber;
  String get hoursOfOperationId => _hoursOfOperationId;
  Set<String> get departmentCodeSet => _departmentCodeSet;
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
  Map<String, dynamic> get json => {
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
