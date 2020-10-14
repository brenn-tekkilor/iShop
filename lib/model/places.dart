import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/pages/poi/expandable_card.dart';
import 'package:ishop/utils/map_utils.dart';
import 'package:ishop/utils/util.dart';

class AisleLocation {
  const AisleLocation(this.id,
      {this.bayNumber,
      this.description,
      this.number,
      this.numberOfFacings,
      this.sequenceNumber,
      this.side,
      this.shelfNumber,
      this.shelfPositionInBay});

  final String id;
  final int bayNumber;
  final String description;
  final int number;
  final int numberOfFacings;
  final int sequenceNumber;
  final String side;
  final int shelfNumber;
  final int shelfPositionInBay;
}

class RetailLocation {
  //#region ctors

  const RetailLocation({
    this.id = '',
    this.address,
    this.phone = '',
    this.latLng,
    this.banner = BannerType.foodAndDrug,
    this.name = '',
    this.hoursOfOperationId = '',
    this.departmentIds,
  });

  //#region factories

  factory RetailLocation.fromJson(Map<String, Object> json) {
    return RetailLocation(
      id: json['id'] ?? '',
      address: Address.fromJson(json['a']) ?? Address(),
      banner: EnumParser.fromString(BannerType.values, json['b']) ??
          BannerType.foodAndDrug,
      departmentIds: (json['d'] as List<String>).toSet() ?? <String>{},
      hoursOfOperationId: json['h'] as String ?? '',
      latLng: json['latLng'] as LatLng ?? LatLng(0.0, 0.0),
      name: json['n'] as String ?? '',
      phone: json['p'] as String ?? '',
    );
  }

  factory RetailLocation.fromDocument(DocumentSnapshot doc) => doc != null
      ? doc.data() != null
          ? RetailLocation(
              id: doc.id,
              address: doc.data()['a'] != null
                  ? Address.fromJson(doc.data()['a'])
                  : Address(),
              banner: EnumParser.fromString(
                  BannerType.values,
                  doc.data()['b'] ??
                      doc.data()['meta']['banner'] ??
                      'foodAndDrug'),
              name: doc.data()['n'] ?? doc.data()['name'] ?? '',
              phone: doc.data()['p'] ?? '',
              latLng: doc.data()['point'] != null
                  ? geoPointToLatLng(doc.data()['point'])
                  : LatLng((doc.data()['g']['a'] as double) ?? 0.0,
                      (doc.data()['g']['o'] as double) ?? 0.0))
          : RetailLocation(id: doc.id)
      : RetailLocation();

  factory RetailLocation.fromMarker(Marker marker) => marker != null
      ? RetailLocation(
          id: marker.markerId.value,
          name: marker.infoWindow.title,
          banner: EnumParser.fromString(
              BannerType.values, marker.infoWindow.snippet ?? 'foodAndDrug'),
          latLng: marker.position ?? LatLng(0.0, 0.0))
      : RetailLocation();

  factory RetailLocation.fromCardInfo(CardInfo info) => info != null
      ? RetailLocation(
          id: info.id,
          name: info.title,
          banner: info.banner,
          latLng: info.latLng,
        )
      : RetailLocation();

  //#endregion

  //#endregion

  //#region properties

  final String id;
  final Address address;
  final LatLng latLng;
  final BannerType banner;
  final String name;
  final String hoursOfOperationId;
  final String phone;
  final Set<String> departmentIds;

  //#endregion
}

class RetailDepartment {
  const RetailDepartment({this.id, this.name});
  final String id;
  final String name;
}

class Address {
  //#region constructors: Address, Address.fromDoc
  const Address({
    this.addressLine1 = '',
    this.locality = LocalityType.phoenix,
    this.zipCode = '',
    this.county = CountyType.maricopa,
    this.administrativeArea = AdministrativeAreaType.az,
    this.country = CountryType.us,
  });

  factory Address.fromJson(Map<String, Object> json) {
    return Address(
        addressLine1: json['a1'] as String ?? '',
        zipCode: json['z'] as String ?? '',
        administrativeArea:
            EnumParser.fromString(AdministrativeAreaType.values, json['s']) ??
                AdministrativeAreaType.az,
        country: CountryType.us,
        county: EnumParser.fromString(
            CountyType.values, json['n'] ?? CountyType.maricopa),
        locality: EnumParser.fromString(
            LocalityType.values, json['c'] ?? LocalityType.phoenix));
  }
  //#endregion
  //#region properties: name, locality, administrativeArea, zipCode, country, county
  final String addressLine1;
  final LocalityType locality;
  final AdministrativeAreaType administrativeArea;
  final String zipCode;
  final CountryType country;
  final CountyType county;
  //#endregion
  //#region @overrides: ==, hashCode
  //#region ==
  @override
  bool operator ==(o) =>
      o is Address &&
      o.addressLine1.toLowerCase() == addressLine1.toLowerCase() &&
      o.locality.index == locality.index &&
      o.administrativeArea.index == administrativeArea.index &&
      o.zipCode == zipCode &&
      o.country.index == country.index &&
      o.county.index == county.index;
  //#endregion
  //#region hashCode
  @override
  int get hashCode =>
      addressLine1.hashCode ^
      locality.index.hashCode ^
      administrativeArea.index.hashCode ^
      zipCode.hashCode ^
      country.index.hashCode ^
      county.index.hashCode;
//endregion
//#endregion
}

class HoursOfOperation {
  const HoursOfOperation(
      {this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.sunday});
  final TimeRangeOfDay monday;
  final TimeRangeOfDay tuesday;
  final TimeRangeOfDay wednesday;
  final TimeRangeOfDay thursday;
  final TimeRangeOfDay friday;
  final TimeRangeOfDay saturday;
  final TimeRangeOfDay sunday;
}
