import 'package:flutter/foundation.dart';
import 'package:ishop/data/service/places_api.dart';

class SheetProvider extends ChangeNotifier {
  SheetProvider() : _api = PlacesAPI.instance();
  final PlacesAPI _api;
}
