import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/data/model/place_info.dart';

extension MarkerToPlaceInfoAdapter on Marker {
  PlaceInfo toPlaceInfo() => PlaceInfo(
        latLng: position,
        banner: infoWindow.snippet,
        name: infoWindow.title,
        id: markerId.value,
      );
}
