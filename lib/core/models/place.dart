import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/core/enums/place_banner.dart';
import 'package:ishop/core/models/place_address.dart';
import 'package:ishop/core/util/parser.dart';

class Place {
  //#region ctors

  const Place({
    this.id = '',
    this.address,
    this.phone = '',
    this.latLng,
    this.banner = PlaceBanner.foodAndDrug,
    this.name = '',
    this.hoursOfOperationId = '',
    this.departmentIds,
  });

  //#region factories

  factory Place.fromJson(Map<String, Object> json) {
    return Place(
      id: json['id'] ?? '',
      address: PlaceAddress.fromJson(json['a']) ?? PlaceAddress(),
      banner: Parser.stringToEnum(PlaceBanner.values, json['b']) ??
          PlaceBanner.foodAndDrug,
      departmentIds: (json['d'] as List<String>).toSet() ?? <String>{},
      hoursOfOperationId: json['h'] as String ?? '',
      latLng: json['latLng'] as LatLng ?? LatLng(0.0, 0.0),
      name: json['n'] as String ?? '',
      phone: json['p'] as String ?? '',
    );
  }

  factory Place.fromDocument(DocumentSnapshot doc) => doc != null
      ? doc.data() != null
          ? Place(
              id: doc.id,
              address: doc.data()['a'] != null
                  ? PlaceAddress.fromJson(doc.data()['a'])
                  : PlaceAddress(),
              banner: Parser.stringToEnum(
                  PlaceBanner.values,
                  doc.data()['b'] ??
                      doc.data()['meta']['banner'] ??
                      'foodAndDrug'),
              name: doc.data()['n'] ?? doc.data()['name'] ?? '',
              phone: doc.data()['p'] ?? '',
              latLng: doc.data()['point'] != null
                  ? Parser.geoPointToLatLng(doc.data()['point']['geopoint'])
                  : LatLng((doc.data()['g']['a'] as double) ?? 0.0,
                      (doc.data()['g']['o'] as double) ?? 0.0))
          : Place(id: doc.id)
      : Place();

  factory Place.fromMarker(Marker marker) => marker != null
      ? Place(
          id: marker.markerId.value,
          name: marker.infoWindow.title,
          banner: Parser.stringToEnum(
              PlaceBanner.values, marker.infoWindow.snippet ?? 'foodAndDrug'),
          latLng: marker.position ?? LatLng(0.0, 0.0))
      : Place();

  factory Place.initial() => Place(
        address: PlaceAddress(),
        latLng: LatLng(0.0, 0.0),
        departmentIds: <String>{},
      );

  //#endregion

  //#endregion

  //#region properties

  final String id;
  final PlaceAddress address;
  final LatLng latLng;
  final PlaceBanner banner;
  final String name;
  final String hoursOfOperationId;
  final String phone;
  final Set<String> departmentIds;

  //#endregion

  Marker toMarker() => Marker(
        markerId: MarkerId(id),
        icon: banner == PlaceBanner.marketplace
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
            : BitmapDescriptor.defaultMarker,
        position: latLng,
        infoWindow: InfoWindow(
          title: name,
          snippet: banner.toString(),
        ),
      );
}
