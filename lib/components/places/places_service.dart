import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:ishop/core/enums/place_banner.dart';
import 'package:ishop/core/models/place.dart';
import 'package:ishop/core/util/parser.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

@lazySingleton
class PlacesService {
  //#region Ctor / factory
  //#region Ctor
  PlacesService({this.collection = 'maplocationmarkers'})
      : _bannerNotifier = ValueNotifier<PlaceBanner>(PlaceBanner.all),
        _radiusNotifier = ValueNotifier<double>(4.0),
        _placeNotifier = ValueNotifier<Place>(Place.initial()),
        _streamSubject = BehaviorSubject.seeded(Tuple2(PlaceBanner.all, 4.0));
  //#endregion
  //#region factory
  @factoryMethod
  factory PlacesService.initial() {
    return PlacesService();
  }
  //#endregion
  //#region static async initializer
  @preResolve
  static Future<PlacesService> get instance async {
    _instance ??= PlacesService.initial();
    _instance = await _instance.initialize();
    return await _instance;
  }

  static PlacesService _instance;
  //#region initialize
  Future<PlacesService> initialize() async {
    _deviceLocation = await waitDeviceLocation;
    final s = await fireStream;
    stream = await s.asBroadcastStream();
    return this;
  }
  //#endregion
  //#endregion

  //#region firestore ref/query/stream/controller/subjects
  //#region firestore refs/query
  // collection name
  final String collection;
  // collection ref
  CollectionReference get firestore =>
      FirebaseFirestore.instance.collection(collection);
  // query ref
  dynamic get query => streamSubject.value.item1 == PlaceBanner.all
      ? firestore
      : firestore.where('meta.banner',
          isEqualTo: Parser.enumToString<PlaceBanner>(banner));
  //#endregion
  //#region Firestore docs stream/controller/subjects
  // Stream
  Stream<List<DocumentSnapshot>> stream;
  Future<Stream<List<DocumentSnapshot>>> get fireStream async =>
      await waitDeviceLocation
          .then((l) async => await streamSubject.switchMap((c) =>
              Geoflutterfire().collection(collectionRef: query).within(
                  center: Parser.latLngToGeoFirePoint(
                      l ?? deviceLocation ?? LatLng(0.0, 0.0)),
                  radius: c.item2,
                  field: 'point',
                  strictMode: true)))
          .catchError((e) => print(e));

  // Controller
  final BehaviorSubject<Tuple2<PlaceBanner, double>> _streamSubject;
  // getter
  BehaviorSubject<Tuple2<PlaceBanner, double>> get streamSubject =>
      _streamSubject;
  //#region stream subjects
  //#region PlaceBanner
  // PlaceBanner Notifier
  final ValueNotifier<PlaceBanner> _bannerNotifier;
  ValueNotifier<PlaceBanner> get bannerNotifier => _bannerNotifier;
  // PlaceBanner value
  PlaceBanner get banner => _bannerNotifier.value;
  set banner(PlaceBanner value) {
    assert(value != null);
    if (_bannerNotifier.value != value) {
      _bannerNotifier.value = value;
      if (radius != null && radius > 0) {
        streamSubject.add(Tuple2<PlaceBanner, double>(value, radius));
      }
    }
  }

  //#endregion
  //#region Radius
  // Radius notifier
  final ValueNotifier<double> _radiusNotifier;
  ValueNotifier<double> get radiusNotifier => _radiusNotifier;
  // Radius value
  double get radius => _radiusNotifier.value;
  set radius(double value) {
    assert(value != null);
    if (radius != value) {
      _radiusNotifier.value = value;
      if (banner != null) {
        streamSubject.add(Tuple2<PlaceBanner, double>(banner, value));
      }
    }
  }

  //#endregion
  //#endregion
  //#endregion
  //#region TODO: move placeNotifier to a single value global stream provider
  final ValueNotifier<Place> _placeNotifier;
  ValueNotifier<Place> get placeNotifier => _placeNotifier;
  Place get place => placeNotifier.value;
  set place(Place value) {
    if (value != null && placeNotifier.value != value) {
      placeNotifier.value = value;
    }
  }
  //#endregion
  //#endregion

  //#region device location
  LatLng _deviceLocation;
  LatLng get deviceLocation => _deviceLocation;
  set deviceLocation(LatLng value) {
    assert(value != null);
    if (deviceLocation != value) {
      _deviceLocation = value;
    }
  }

  Future<LatLng> get waitDeviceLocation async =>
      _deviceLocation ??
      await Geolocator.getCurrentPosition().then((p) async {
        _deviceLocation = Parser.posToLatLng(await p);
        return await _deviceLocation;
      }).catchError((e) => print(e));
  //#endregion

  //#region places list controls
  ScrollController placesList;
  Future<void> animateListTo(String value) async {
    if (placesList != null) {
      placesList.jumpTo(0.0);
      placesList.jumpTo(100.0);
      final index = await fireStream
          .then((s) async => (await s.first).indexWhere((e) => e.id == value))
          .catchError((e) => print(e));
      await placesList.animateTo(140 + 60.0 * index,
          duration: Duration(milliseconds: 800), curve: Curves.easeInOut);
    }
  }
  //#endregion

  //#region GoogleMap controls
  GoogleMapController placesMap;
  Future<void> animateMapTo(LatLng latLng) async =>
      await placesMap.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLng,
          zoom: 16,
        ),
      ));
  Future<void> animateMapZoom(double value) async =>
      await placesMap.animateCamera(CameraUpdate.zoomTo(value));
  //#endregion
}
