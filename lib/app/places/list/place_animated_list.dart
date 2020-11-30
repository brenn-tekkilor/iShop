import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ishop/app/places/places_provider.dart';
import 'package:ishop/data/model/animated_list_model.dart';
import 'package:ishop/data/model/place_card_item.dart';
import 'package:ishop/data/model/place_info.dart';
import 'package:provider/provider.dart';

/// PlaceAnimatedList
class PlaceAnimatedList extends StatefulWidget {
  /// PlaceAnimatedList default const constructor
  const PlaceAnimatedList({Key? key}) : super(key: key);

  /// createState
  @override
  _PlaceAnimatedListState createState() => _PlaceAnimatedListState();
}

class _PlaceAnimatedListState extends State<PlaceAnimatedList> {
  final _listKey = GlobalKey<SliverAnimatedListState>();
  late final AnimatedListModel<PlaceCardItem> _listModel;
  StreamSubscription<List<PlaceInfo>>? _placeSubscription;
  List<PlaceCardItem> _places = <PlaceCardItem>[];

  @override
  void initState() {
    super.initState();
    _listModel = AnimatedListModel<PlaceCardItem>(
        listKey: _listKey,
        removedItemBuilder: _buildRemovedItem,
        initialItems: <PlaceCardItem>[_defaultCardItem]);
    _placeSubscription = Provider.of<PlacesProvider>(context, listen: false)
        .places
        .listen(_updatePlaces);
  }

// Used to build list items that haven't been removed.
  Widget _buildItem(
          BuildContext context, int index, Animation<double> animation) =>
      SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1.5, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: const Interval(
              0,
              1,
              curve: Curves.elasticIn,
            ),
          ),
        ),
        child: _places[index],
      );

  Widget _buildRemovedItem(PlaceCardItem card, int index, BuildContext context,
          Animation<double> animation) =>
      _places.isEmpty ? _defaultCardItem : _places[index];

  void _updatePlaces(List<PlaceInfo> value) {
    final items = <PlaceCardItem>[];
    for (var i = 0; i < value.length; i++) {
      items.add(value[i].toPlaceCard(index: i));
    }
    _listModel.update(items);
    _places = items;
  }

  @override
  void dispose() {
    if (_placeSubscription != null) {
      _placeSubscription?.cancel();
      _placeSubscription = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SliverPadding(
        padding: const EdgeInsets.all(8),
        sliver: SliverAnimatedList(
          key: _listKey,
          initialItemCount: _listModel.length,
          itemBuilder: _buildItem,
        ),
      );

  static const _defaultCardItem = PlaceCardItem(
    index: 0,
    info: PlaceInfo(),
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<StreamSubscription<List<PlaceInfo>>>(
        '_placeSubscription', _placeSubscription));
  }
}
