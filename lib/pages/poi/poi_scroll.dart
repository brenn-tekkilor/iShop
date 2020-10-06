import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/pages/poi/poi_state.dart';
import 'package:ishop/pages/poi/poi_toggles.dart';
import 'package:ishop/utils/colors.dart';
import 'package:ishop/utils/map_utils.dart';

class POIScroll extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _POIScrollState();
}

class _POIScrollState extends State<POIScroll> {
  final _cards = <CardItem>{};
  POIState _data;
  Completer _controller;
  StreamSubscription<List<DocumentSnapshot>> _subscription;

  void _addCard(CardItem value) {
    assert(value != null);
    if (!_cards.contains(value)) {
      _cards.removeWhere((e) => e.key == value.key);
      _cards.add(value);
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
        await _controller.future
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
    _cards.clear();
    docs.forEach((e) => _addCard(_docToCard(e)));
    setState(() {});
  }

  PreferredSizeWidget get _poiSlider => PreferredSize(
        child: Slider(
          min: 2.0,
          max: 100,
          value: _data.radius,
          onChanged: (value) => _data.radius = value,
          activeColor: Colors.cyan.withOpacity(0.8),
          inactiveColor: Colors.cyan.withOpacity(0.2),
        ),
        preferredSize: Size.fromHeight(60.0),
      );

  Padding get _poiToggles => Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 50, 0),
        child: POITogglesBar(),
      );

  @override
  Widget build(BuildContext context) {
    _data ??= POIStateContainer.of(context).state;
    _controller ??= _data.mapController;
    _subscription ??= _data.poiStream.listen(_updateCards);

    return DraggableScrollableSheet(
        initialChildSize: 0.1,
        minChildSize: 0.1,
        maxChildSize: 0.7,
        expand: true,
        builder: (context, scrollController) {
          _data.poiScrollController = scrollController;
          return CustomScrollView(
            controller: _data.poiScrollController,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.blueGrey.withOpacity(0.2),
                toolbarHeight: 40,
                collapsedHeight: 45,
                expandedHeight: 100.0,
                floating: true,
                snap: true,
                actions: <Widget>[
                  _poiSlider,
                  _poiToggles,
                ],
              ),
              //bottom:
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _cards.elementAt(index),
                  childCount: _cards.length,
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
          height: 100,
          child: Card(
            color: data.subtitle == 'marketplace'
                ? AppColors.primaryLightColor.withOpacity(0.6)
                : AppColors.secondaryLightColor.withOpacity(0.6),
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
