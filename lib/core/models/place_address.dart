import 'package:ishop/core/enums/administrative_area.dart';
import 'package:ishop/core/enums/country.dart';
import 'package:ishop/core/enums/county.dart';
import 'package:ishop/core/enums/locality.dart';
import 'package:ishop/core/util/parser.dart';

class PlaceAddress {
  //#region Ctors
  const PlaceAddress({
    this.addressLine1 = '',
    this.locality = Locality.phoenix,
    this.zipCode = '',
    this.county = County.maricopa,
    this.administrativeArea = AdministrativeArea.az,
    this.country = Country.us,
  });

  factory PlaceAddress.fromJson(Map<String, Object> json) {
    return PlaceAddress(
        addressLine1: json['a1'] as String ?? '',
        zipCode: json['z'] as String ?? '',
        administrativeArea:
            Parser.stringToEnum(AdministrativeArea.values, json['s']) ??
                AdministrativeArea.az,
        country: Country.us,
        county:
            Parser.stringToEnum(County.values, json['n'] ?? County.maricopa),
        locality: Parser.stringToEnum(
            Locality.values, json['c'] ?? Locality.phoenix));
  }
  //#endregion
  //#region properties: name, locality, administrativeArea, zipCode, country, county
  final String addressLine1;
  final Locality locality;
  final AdministrativeArea administrativeArea;
  final String zipCode;
  final County county;
  final Country country;
  //#endregion
  //#region @overrides: ==, hashCode
  //#region ==
  @override
  bool operator ==(o) =>
      o is PlaceAddress &&
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
