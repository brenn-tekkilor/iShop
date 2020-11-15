import 'package:ishop/data/enums/administrative_area.dart';
import 'package:ishop/data/enums/country.dart';
import 'package:ishop/data/enums/county.dart';
import 'package:ishop/data/enums/locality.dart';
import 'package:ishop/util/enum_parser.dart';

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

  factory PlaceAddress.fromJson(Map<String, dynamic> json) {
    return PlaceAddress(
        addressLine1: json['a1'],
        zipCode: json['z'],
        administrativeArea: EnumParser.fromString<AdministrativeArea>(
            AdministrativeArea.values, json['s'])!,
        country: Country.us,
        county: EnumParser.fromString<County>(County.values, json['u'])!,
        locality: EnumParser.fromString<Locality>(Locality.values, json['c'])!);
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
  Map<String, dynamic> get json => {
        'a1': addressLine1,
        'c': locality,
        's': administrativeArea,
        'u': EnumParser.stringValue(county),
        'z': zipCode,
      };
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
