// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:geocoding/geocoding.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:geoflutterfire/geoflutterfire.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:geolocator/geolocator.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/data/model/geo_radius.dart';
import 'package:ishop/util/extensions/json_extensions.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:tuple/tuple.dart';

/*
////  Static Factory class and extension adapters enable conversions between
////  the following types:
////      Map<String, dynamic> // dart/firebase serialized json format
////      List<double>         // List[0] = latitude, List[1] = longitude
////      Tuple2<double, double> // Tuple2.item1 = latitude, Tuple2.item2 = longitude
////      LatLng    // GoogleMaps libraries public interface
////      Coordinates  // GeoFirePoint private wrapper for lat and long values
////      GeoFirePoint // GeoFirePoint public interface
////      GeoPoint // Firebase public interface
////      Location // GeoLocator public interface
////      Position  // GeoCoding public interface
////      GeoRadius  // Behavior Subject
 */
//#region typedef T LatitudeLongitudeFactoryFunction<T>(double, double)
/// geo conversion function type definition
typedef LatitudeLongitudeFactoryFunction<T> = T Function(
    double latitude, double longitude);

//#endregion
/// Latitude Longitude Type classes adapter factory
abstract class LatitudeLongitudeTypeFactory {
  //#region static Map<Type, GeoAdapterAsFunc> _asMap
  static const _asMap = <Type, LatitudeLongitudeFactoryFunction>{
    Map: _asData,
    List: _asList,
    Tuple2: _asTuple,
    LatLng: _asLatLng,
    Coordinates: _asCoordinates,
    GeoFirePoint: _asGeoFirePoint,
    GeoPoint: _asGeoPoint,
    Position: _asPosition,
    Location: _asLocation,
    Marker: _asMarker,
    GeoRadius: _asGeoRadius,
  };
  //#endregion
  //#region constructors
  //#region Map<String, dynamic> _asData
  static Map<String, dynamic> _asData(double latitude, double longitude) =>
      <String, dynamic>{'latitude': latitude, 'longitude': longitude};
  //#endregion
  //#region List<double> _asList
  static List<double> _asList(double latitude, double longitude) =>
      <double>[latitude, longitude];
  //#endregion
  //#region Tuple2<double, double> _asTuple
  static Tuple2<double, double> _asTuple(double latitude, double longitude) =>
      Tuple2(latitude, longitude);
  //#endregion
  //#region Coordinates _asCoordinates
  static Coordinates _asCoordinates(double latitude, double longitude) =>
      Coordinates(latitude, longitude);
  //#endregion
  //#region LatLng _asLatLng
  static LatLng _asLatLng(double latitude, double longitude) =>
      LatLng(latitude, longitude);
  //#endregion
  //#region GeoFirePoint _asGeoFirePoint
  static GeoFirePoint _asGeoFirePoint(double latitude, double longitude) =>
      GeoFirePoint(latitude, longitude);
  //#endregion
  //#region GeoPoint _asGeoPoint
  static GeoPoint _asGeoPoint(double latitude, double longitude) =>
      GeoPoint(latitude, longitude);
  //#endregion
  //#region Location _asLocation
  static Location _asLocation(double latitude, double longitude) =>
      Location(latitude: latitude, longitude: longitude);
  //#endregion
  //#region Position _asPosition
  static Position _asPosition(double latitude, double longitude) =>
      Position(latitude: latitude, longitude: longitude);
  //#endregion
  //#region Marker _asMarker
  static Marker _asMarker(double latitude, double longitude) => Marker(
        markerId: MarkerId('$latitude, $longitude'),
        position: LatLng(latitude, longitude),
      );
  //#endregion
  //#region GeoRadius _asGeoRadius
  static GeoRadius _asGeoRadius(double latitude, double longitude) =>
      GeoRadius(latitude: latitude, longitude: longitude);
  //#endregion
  //#endregion
  /// make function
  static T? make<T>(double? latitude, double? longitude) {
    dynamic d;
    if (_asMap.containsKey(T)) {
      final func = _asMap[T];
      if (func != null) {
        d = func(normalizeLatitude(latitude), normalizeLongitude(longitude));
      }
    }
    return d is T ? d : null;
  }

  //#region normalize helpers
  /// normalize latitude
  static double normalizeLatitude(double? latitude) =>
      (latitude != null && latitude > -90.0 && 90.0 > latitude)
          ? latitude
          : _defaultLatitude;

  /// normalize longitude
  static double normalizeLongitude(double? longitude) => longitude != null
      ? (longitude + 180.0) % 360.0 - 180.0
      : _defaultLongitude;
//#endregion
  //#region static defaults
  static const _defaultLatitude = 33.646132;
  static const _defaultLongitude = -112.023964;
  //#endregion
}

//#region extensions [T]LatitudeLongitudeAdapter on T
//#region T? [Map<String, dynamic>].to<T>()
/// json map extensions
extension JsonMapExtensions on Map<String, dynamic> {
  /// json map geo conversions
  T? to<T>() => LatitudeLongitudeTypeFactory.make<T>(latitude, longitude);
}

//#endregion
//#region T? [List<double?>].to<T>()
/// list where index 0 is latitude and index 1 is longitude
extension ListLatitudeLongitudeAdapter on List<double?> {
  /// list geo conversions
  T? to<T>() => LatitudeLongitudeTypeFactory.make<T>(this[0], this[1]);
}

//#endregion
//#region T? [Tuple2<double?, double?>].to<T>()
/// Tuple geo extension
extension TupleLatitudeLongitudeAdaper on Tuple2<double?, double?> {
  /// Tuple geo conversion
  T? to<T>() => LatitudeLongitudeTypeFactory.make<T>(item1, item2);
}

//#endregion
//#region T? [LatLng].to<T>()
/// LatLng geo extension
extension LatLngLatitudeLongitudeAdapter on LatLng {
  /// LatLng geo conversion
  T? to<T>() => LatitudeLongitudeTypeFactory.make<T>(latitude, longitude);
}

//#endregion
//#region T? [Coordinates].to<T>()
//// coordinates geo extensions
extension CoordinatesLngLatitudeLongitudeAdapter on Coordinates {
  /// coordinates geo conversion
  T? to<T>() => LatitudeLongitudeTypeFactory.make<T>(latitude, longitude);
}

//#endregion
//#region T? [GeoFirePoint].to<T>()
/// GeoFirePoint geo extension
extension GeoFirePointLatitudeLongitudeAdapter on GeoFirePoint {
  /// GeoFirePoint geo conversion
  T? to<T>() => LatitudeLongitudeTypeFactory.make<T>(latitude, longitude);
}

//#endregion
//#region T? [GeoPoint].to<T>()
/// GeoPoint geo extension
extension GeoPointLatitudeLongitudeAdapter on GeoPoint {
  /// GeoPoint geo conversion
  T? to<T>() => LatitudeLongitudeTypeFactory.make<T>(latitude, longitude);
}

//#endregion
//#region T? [Location].to<T>()
/// Location geo extensions
extension LocationLatitudeLongitudeAdapter on Location {
  /// Location geo conversion
  T? to<T>() => LatitudeLongitudeTypeFactory.make<T>(latitude, longitude);
}

//#endregion
//#region T? [Position].to<T>()
/// Position geo extension
extension PositionLatitudeLongitudeAdapter on Position {
  /// Position geo conversion
  T? to<T>() => LatitudeLongitudeTypeFactory.make<T>(latitude, longitude);
}

//#endregion
//#region T? [Position].to<T>()
/// GeoRadius geo extension
extension GeoRadiusLatitudeLongitudeAdapter on GeoRadius {
  /// GeoRadius geo conversion
  T? to<T>() => LatitudeLongitudeTypeFactory.make<T>(latitude, longitude);
}
//#endregion
//#endregion
