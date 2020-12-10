import 'package:flutter/foundation.dart';
import 'package:ishop/data/model/place_details.dart';

/// HomeProvider
class HomeProvider extends ChangeNotifier {
  /// HomeProvider constructor
  HomeProvider();

  PlaceDetails? _preferredPlace;

  /// preferredPlace
  PlaceDetails? get preferredPlace => _preferredPlace;
  set preferredPlace(PlaceDetails? value) {
    if (preferredPlace != value) {
      _preferredPlace = value;
      notifyListeners();
    }
  }
}
