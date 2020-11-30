import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/data/model/place_info.dart';

/// Google Map Marker Extensions
extension MarkerExtensions on Marker {
  /// place info
  PlaceInfo get placeInfo => PlaceInfo(
        latLng: position,
        banner: infoWindow.snippet,
        name: infoWindow.title,
        id: markerId.value,
      );
}
