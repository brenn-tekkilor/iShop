import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ishop/app/places/place_animated_list_card.dart';
import 'package:ishop/app/places/places_provider.dart';
import 'package:ishop/data/model/animated_list_model.dart';
import 'package:ishop/data/model/place_details.dart';
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
  late final AnimatedListModel<PlaceDetails> _list;
  StreamSubscription<List<PlaceDetails>>? _places;

  @override
  void initState() {
    super.initState();
    _list = AnimatedListModel<PlaceDetails>(
        listKey: _listKey,
        removedItemBuilder: _buildRemovedItem,
        initialItem: const PlaceDetails(id: '0'));
    _places = Provider.of<PlacesProvider>(context, listen: false)
        .places
        .listen(_updatePlaces);
  }

// Used to build list items that haven't been removed.
  Widget _buildItem(
          BuildContext context, int index, Animation<double> animation) =>
      PlaceAnimatedListCard<PlaceDetails>(
          item: _list[index],
          index: index,
          animation: animation,
          isSelected: Provider.of<PlacesProvider>(context, listen: false)
                  .selectedPlace ==
              _list[index],
          onTap: () => Provider.of<PlacesProvider>(context, listen: false)
              .selectedPlace = _list[index]);

  Widget _buildRemovedItem(PlaceDetails? item, BuildContext context,
          Animation<double> animation) =>
      PlaceAnimatedListCard<PlaceDetails>(
        item: item!,
        animation: animation,
        index: _list.indexOf(item),
        onTap: () {},
      );

  void _updatePlaces(List<PlaceDetails> value) {
    _list
        .where((e) => !value.contains(e))
        .toList(growable: false)
        .forEach(_list.remove);
    value
        .where((e) => !_list.contains(e))
        .toList(growable: false)
        .forEach(_list.add);
  }

  @override
  void dispose() {
    if (_places != null) {
      _places?.cancel();
      _places = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SliverPadding(
        padding: const EdgeInsets.all(8),
        sliver: SliverAnimatedList(
          key: _listKey,
          initialItemCount: _list.length,
          itemBuilder: _buildItem,
        ),
      );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<StreamSubscription<List<PlaceDetails>>>(
        '_places', _places));
  }
}
