import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/model/retail_location.dart';

class RetailLocationsService extends ChangeNotifier {
  RetailLocationsService._create() : _firestore = FirebaseFirestore.instance;

  static RetailLocationsService getInstance() {
    _instance ??= RetailLocationsService._create();
    return _instance;
  }

  static RetailLocationsService _instance;
  final FirebaseFirestore _firestore;
  final _retailLocations = <String, RetailLocation>{};
  final _markers = <Marker>[];
  RetailLocation _targetLocation;

  void _addRetailLocationFromDocumentSnapshot(
      String key, QueryDocumentSnapshot doc) {
    if (!_retailLocations.containsKey(key)) {
      final _retailLocation = RetailLocation.fromDoc(doc);
      retailLocations[key] = _retailLocation;
    }
  }

  void _addRetailLocation(RetailLocation retailLocation) {
    if (!retailLocations.containsKey(retailLocation.id)) {
      retailLocations[retailLocation.id] = retailLocation;
    }
  }

  Future<void> updateRetailLocations() async {
    final _querySnapshot = await _firestore.collection('retaillocations').get();
    _querySnapshot.docs.forEach((doc) {
      final _retailLocation = RetailLocation.fromDoc(doc);
      _addRetailLocation(_retailLocation);
      //_addRetailLocationFromDocumentSnapshot(doc.id, doc);
    });
    notifyListeners();
  }

  //region getters/setters

  List<Marker> get markers => _markers;

  Map<String, RetailLocation> get retailLocations => _retailLocations;

  RetailLocation get targetLocation => _targetLocation;

  set targetLocation(RetailLocation value) {
    assert(value != null);
    if (_targetLocation != value) {
      _targetLocation = value;
      notifyListeners();
    }
  }
  //#endregion
}