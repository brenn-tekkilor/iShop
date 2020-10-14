import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ishop/pages/poi/expandable_card.dart';
import 'package:ishop/pages/poi/poi_slider.dart';
import 'package:ishop/pages/poi/poi_state.dart';
import 'package:ishop/pages/poi/poi_switch.dart';
import 'package:ishop/utils/util.dart';

class POIScroll extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _POIScrollState();
}

class _POIScrollState extends State<POIScroll> with TickerProviderStateMixin {
  //#region properties

  AppData _data;
  final _cards = <ExpandableCard>{};
  final _foodAndDrugSwitch = POISwitch(banner: BannerType.foodAndDrug);
  final _marketplaceSwitch = POISwitch(banner: BannerType.marketplace);
  final _slider = POISlider();
  StreamSubscription<List<DocumentSnapshot>> _streamSubscription;

  //#region methods
  void _addCard(ExpandableCard value) {
    if (!_cards.contains(value)) {
      _cards.removeWhere((e) => e.key == value.key);
      _cards.add(value);
    }
  }

  void _updateCards(List<DocumentSnapshot> docs) {
    _cards.clear();
    docs.forEach((e) => _addCard(ExpandableCard.fromDocument(e)));
    setState(() {});
  }

  double get _width => MediaQuery.of(context).size.width;

  //#endregion

  //#endregion

  //#region overrides

  //#region build

  @override
  Widget build(BuildContext context) {
    _data ??= AppState.of(context).state;
    _streamSubscription ??= _data.poiStream.listen(_updateCards);
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
                elevation: 100,
                backgroundColor: Theme.of(context).accentColor.withOpacity(0.9),
                automaticallyImplyLeading: false,
                toolbarHeight: 56,
                collapsedHeight: 60,
                expandedHeight: 62,
                pinned: true,
                shadowColor: Theme.of(context).shadowColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                actions: <Widget>[
                  Container(
                    width: _width / 2.0,
                    height: 50,
                    padding: EdgeInsets.only(
                      left: 2.0,
                      bottom: 4.0,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Text('FOOD & DRUG', textAlign: TextAlign.justify),
                        _foodAndDrugSwitch,
                      ],
                    ),
                  ),
                  Container(
                    width: _width / 2.0,
                    height: 50,
                    padding: EdgeInsets.only(
                      left: 2.0,
                      bottom: 4.0,
                    ),
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Text('MARKETPLACE', textAlign: TextAlign.justify),
                        _marketplaceSwitch,
                      ],
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: _slider,
              ),
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

  //#endregion
}
