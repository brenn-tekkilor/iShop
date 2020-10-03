import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:ishop/secrets.dart';

class POITile extends StatefulWidget {
  const POITile({
    Key key,
    @required this.document,
    @required this.mapController,
  }) : super(key: key);
  final DocumentSnapshot document;
  final Completer<GoogleMapController> mapController;

  @override
  State<StatefulWidget> createState() {
    return POITileState();
  }
}

class POITileState extends State<POITile> {
  final _placesApiClient =
      GoogleMapsPlaces(apiKey: Secrets.androidGoogleMapsAPIKey);
  String _placePhotoUrl = '';
  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    _retrievePlacesDetails();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  Future<void> _retrievePlacesDetails() async {
    final details = await _placesApiClient
        .getDetailsByPlaceId(widget.document.data()['placesId'] as String);
    if (!_disposed) {
      setState(() {
        _placePhotoUrl = _placesApiClient.buildPhotoUrl(
          photoReference: details.result.photos[0].photoReference,
          maxHeight: 300,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.document.data()['name'] as String),
      subtitle: Text(widget.document.data()['address'] as String),
      leading: Container(
        width: 100,
        height: 100,
        child: _placePhotoUrl.isNotEmpty
            ? ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(2)),
                child: Image.network(_placePhotoUrl, fit: BoxFit.cover),
              )
            : Container(),
      ),
      onTap: () async {
        final controller = await widget.mapController.future;
        await controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                widget.document.data()['location'].latitude as double,
                widget.document.data()['location'].longitude as double,
              ),
              zoom: 16,
            ),
          ),
        );
      },
    );
  }
}
