import 'package:flutter/foundation.dart';
import 'package:ishop/app/service_locator.dart';
import 'package:ishop/core/models/place.dart';
import 'package:ishop/services/places_service.dart';
import 'package:ishop/views/base/base_model.dart';

class HomeModel extends BaseModel {
  final srv = locator<PlacesService>();

  ValueNotifier<Place> get placeNotifier => srv.placeNotifier;
}
