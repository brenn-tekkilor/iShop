// ignore: import_of_legacy_library_into_null_safe
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/data/enums/place_banner.dart';
import 'package:ishop/data/model/place_details.dart';
import 'package:ishop/util/enum_parser.dart';

/// Google Map Marker Extensions
extension MarkerExtensions on Marker {
  /// place info
  PlaceDetails get placeDetails => PlaceDetails(
        latLng: position,
        banner: EnumParser.fromString(PlaceBanner.values, infoWindow.snippet) ??
            PlaceBanner.foodAndDrug,
        name: infoWindow.title,
        id: markerId.value,
      );
}
