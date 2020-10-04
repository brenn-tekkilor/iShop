import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

enum BannerType {
  all,
  foodAndDrug,
  marketplace,
}

enum LocalityType { phoenix }

enum DialogActionType {
  agree,
  cancel,
  disagree,
  disregard,
}

enum CountryType {
  us,
}

enum CountyType {
  maricopa,
}

enum HTMLImageSizeType {
  small,
  medium,
  large,
  xlarge,
  thumbnail,
}

enum PerspectiveType {
  front,
  back,
  top,
  bottom,
  side,
}

enum UnitOfMeasureType {
  count, //ct
  unit,
  inch, //in
}

enum AdministrativeAreaType {
  az, // Arizona
}

enum TaxonomyType {
  retailSales,
  foodForHomeConsumption,
}

enum TemperatureIndicatorType { ambient }

class Address {
  //#region constructors: Address, Address.fromDoc
  Address(
    this.name,
    this.locality,
    this.zipCode, {
    AdministrativeAreaType administrativeArea = AdministrativeAreaType.az,
    CountyType countyType = CountyType.maricopa,
  });
  Address.fromMap(Map datamap) {
    name = datamap['a1'];
    if (datamap.containsKey('a2')) {
      name += ', ${datamap['a2']}';
    }
    locality = LocalityType.values.firstWhere((e) =>
        e.toString() == 'LocalityType.' + ReCase(datamap['c']).camelCase);
    administrativeArea = AdministrativeAreaType.values.firstWhere((e) =>
        e.toString() ==
        'AdministrativeAreaType.' + ReCase(datamap['s']).camelCase);
    zipCode = datamap['z'];
    county = CountyType.values.firstWhere(
        (e) => e.toString() == 'CountyType.' + ReCase(datamap['u']).camelCase);
  }
  //#endregion
  //#region properties: name, locality, administrativeArea, zipCode, country, county
  String name;
  LocalityType locality;
  AdministrativeAreaType administrativeArea;
  String zipCode;
  final CountryType country = CountryType.us;
  CountyType county;
  //#endregion
  //#region @overrides: ==, hashCode
  //#region ==
  @override
  bool operator ==(o) =>
      o is Address &&
      o.name.toLowerCase() == name.toLowerCase() &&
      o.locality.index == locality.index &&
      o.administrativeArea.index == administrativeArea.index &&
      o.zipCode == zipCode &&
      o.country.index == country.index &&
      o.county.index == county.index;
  //#endregion
  //#region hashCode
  @override
  int get hashCode =>
      name.hashCode ^
      locality.index.hashCode ^
      administrativeArea.index.hashCode ^
      zipCode.hashCode ^
      country.index.hashCode ^
      county.index.hashCode;
  //endregion
//#endregion
}

class Bounds {
  double x;
  double y;
}

class FilterActionNotification extends Notification {
  const FilterActionNotification({this.value});
  final int value;
}

class GeoLocation {
  double latitude;
  double longitude;
  List<double> latlng() {
    return [latitude, longitude];
  }

  @override
  String toString() {
    return '$latitude, $longitude';
  }
}

class HoursOfOperation {
  TimeRangeOfDay monday;
  TimeRangeOfDay tuesday;
  TimeRangeOfDay wednesday;
  TimeRangeOfDay thursday;
  TimeRangeOfDay friday;
  TimeRangeOfDay saturday;
  TimeRangeOfDay sunday;
}

class HTMLImage {
  HTMLImageSizeType size;
  String url;
}

class Measurement {
  double value;
  UnitOfMeasureType unitOfMeasure;
}

class TimeRangeOfDay {
  TimeOfDay start;
  TimeOfDay end;
  bool is24Hours;
}

BannerType parseBannerType(String value) {
  assert(value != null && value.isNotEmpty);
  return BannerType.values.firstWhere((v) => v.toString() == value);
}

String enumValue<T>(T value) {
  assert(value != null);
  return value.toString().replaceFirst(RegExp(r"[A-Za-z0-9-_']+?\."), '');
}
