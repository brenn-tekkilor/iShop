import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class RetailLocationsList extends StatelessWidget {
  final geo = Geoflutterfire();
  final retailLocations =
      FirebaseFirestore.instance.collection('retaillocations');
  final markers = FirebaseFirestore.instance.collection('maplocationmarkers');

  Future<ListTile> addMarker(QueryDocumentSnapshot snapshot) async {
    final id = snapshot.id;
    final data = snapshot.data();
    final latitude = data['g']['a'];
    final longitude = data['g']['o'];
    final point = geo.point(latitude: latitude, longitude: longitude);
    final name = data['n'];
    final doc = {
      'point': point.data,
      'name': name,
      'meta': {'banner': data['b']},
    };
    final d = await markers.doc(id).set(doc);
    return ListTile(
      title: Text(id),
      subtitle: Text(name),
    );
  }

  Future<List<ListTile>> addMarkers() async {
    final locations = await retailLocations.get();
    final result = <ListTile>[];
    locations.docs.forEach((e) async {
      final t = await addMarker(e);
      result.add(t);
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ListTile>>(
        future: addMarkers(),
        builder: (BuildContext context, AsyncSnapshot<List<ListTile>> tiles) {
          if (tiles.hasError) {
            return Text('Something went wrong');
          }
          if (tiles.connectionState == ConnectionState.waiting) {
            return Text('loading');
          }
          return ListView(shrinkWrap: true, children: tiles.data);
        });
  }
}
