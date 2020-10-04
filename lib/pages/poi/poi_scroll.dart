import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/pages/poi/poi_filter.dart';
import 'package:ishop/pages/poi/poi_slider.dart';
import 'package:ishop/pages/poi/poi_state.dart';
import 'package:ishop/utils/map_utils.dart';

class POIScroll extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _POIScrollState();
}

class _POIScrollState extends State<POIScroll> {
  final cards = <CardItem>{};
  POIState data;
  Completer controller;
  StreamSubscription<List<DocumentSnapshot>> subscription;

  void _addCard(CardItem value) {
    assert(value != null);
    if (!cards.contains(value)) {
      cards.removeWhere((e) => e.key == value.key);
      cards.add(value);
    }
  }

  CardItem _docToCard(DocumentSnapshot doc) {
    final data = doc.data();
    final banner = data['meta']['banner'];
    final point = data['point']['geopoint'];
    return CardItem(
      key: ValueKey(doc.id),
      data: CardItemData(
        title: data['name'],
        subtitle: banner,
      ),
      onTap: () async {
        await controller.future
            .then((value) => value.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: geoPointToLatLng(point),
                    zoom: 16,
                  ),
                )))
            .catchError((e) => print(e));
      },
    );
  }

  void _updateCards(List<DocumentSnapshot> docs) {
    cards.clear();
    docs.forEach((e) => _addCard(_docToCard(e)));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    data = POIStateContainer.of(context).state;
    controller = data.mapController;
    subscription = data.poiStream.listen(_updateCards);

    return DraggableScrollableSheet(
        initialChildSize: 0.1,
        minChildSize: 0.1,
        maxChildSize: 0.7,
        expand: true,
        builder: (context, scrollController) {
          return CustomScrollView(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            slivers: <Widget>[
              SliverAppBar(
                  title: Text('Options'),
                  backgroundColor: Colors.blueGrey.withOpacity(0.2),
                  toolbarHeight: 40,
                  collapsedHeight: 45,
                  centerTitle: true,
                  expandedHeight: 100.0,
                  floating: true,
                  snap: true,
                  elevation: 99.0,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  actions: <Widget>[
                    POIFilter(),
                  ],
                  bottom: PreferredSize(
                    child: POISlider(),
                    preferredSize: Size.fromHeight(60.0),
                  )),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => cards.elementAt(index),
                  childCount: cards.length,
                ),
              ),
            ],
          );
        });
  }
}

class CardItem extends StatelessWidget {
  const CardItem(
      {Key key, this.onTap, @required this.data, this.selected = false})
      : assert(data != null),
        super(key: key);

  final VoidCallback onTap;
  final CardItemData data;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    var titleTextStyle = Theme.of(context).textTheme.headline6;
    var subtitleTextStyle = Theme.of(context).textTheme.caption;
    if (selected) {
      titleTextStyle =
          titleTextStyle.copyWith(color: Colors.lightGreenAccent[400]);
      subtitleTextStyle =
          subtitleTextStyle.copyWith(color: Colors.lightGreenAccent[400]);
    }
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          height: 104,
          child: Card(
            color: data.subtitle == 'marketplace' ? Colors.green : Colors.grey,
            child: Center(
              child: Text(data.title, style: titleTextStyle),
            ),
          ),
        ),
      ),
    );
  }
}

class CardItemData {
  CardItemData({@required this.title, @required this.subtitle})
      : assert(title != null),
        assert(subtitle != null);

  final String title;
  final String subtitle;
}
