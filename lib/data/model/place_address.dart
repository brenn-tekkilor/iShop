import 'package:flutter/cupertino.dart';
import 'package:ishop/data/enums/administrative_area.dart';
import 'package:ishop/data/enums/country.dart';
import 'package:ishop/data/enums/county.dart';
import 'package:ishop/data/enums/locality.dart';
import 'package:ishop/util/enum_parser.dart';

@immutable

/// the postal address of a place
class PlaceAddress {
  //#region Ctors
  /// default constructor
  const PlaceAddress({
    this.addressLine1 = '',
    this.locality = Locality.phoenix,
    this.zipCode = '',
    this.county = County.maricopa,
    this.administrativeArea = AdministrativeArea.az,
    this.country = Country.us,
  });

  /// constructs a place from a json map
  factory PlaceAddress.fromJson(Map<String, dynamic> json) => PlaceAddress(
      addressLine1: json['a1'].toString(),
      zipCode: json['z'].toString(),
      administrativeArea: EnumParser.fromString<AdministrativeArea>(
          AdministrativeArea.values, json['s'].toString())!,
      county:
          EnumParser.fromString<County>(County.values, json['u'].toString())!,
      locality: EnumParser.fromString<Locality>(
          Locality.values, json['c'].toString())!);
  //#endregion
  //#region properties
  /// first line of address
  final String addressLine1;

  /// city or district
  final Locality locality;

  /// state or province
  final AdministrativeArea administrativeArea;

  /// zip code
  final String zipCode;

  /// county
  final County county;

  /// country
  final Country country;
  //#endregion
  /// converts place address to a json map
  Map<String, dynamic> get json => <String, dynamic>{
        'a1': addressLine1,
        'c': locality,
        's': administrativeArea,
        'u': EnumParser.stringValue(county),
        'z': zipCode,
      };
  //#region @overrides: ==, hashCode
  //#region ==
  @override
  bool operator ==(Object other) =>
      other is PlaceAddress &&
      other.addressLine1.toLowerCase() == addressLine1.toLowerCase() &&
      other.locality.index == locality.index &&
      other.administrativeArea.index == administrativeArea.index &&
      other.zipCode == zipCode &&
      other.country.index == country.index &&
      other.county.index == county.index;
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
