import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ishop/app/places/list/place_card_item.dart';
import 'package:ishop/app/places/places_provider.dart';
import 'package:ishop/data/model/list_model.dart';
import 'package:ishop/data/model/place_info.dart';
import 'package:ishop/data/service/places_api.dart';
import 'package:provider/provider.dart';

class PlacesList extends StatefulWidget {
  @override
  _PlacesListState createState() => _PlacesListState();
}

class _PlacesListState extends State<PlacesList> with TickerProviderStateMixin {
  final api = PlacesAPI.instance();
  final placesSet = <PlaceInfo>{};
  late final ListModel<PlaceInfo> _list;
  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final AnimationController _controller;
  StreamSubscription<Set<PlaceInfo>>? placesSubscription;
  late final Animation<double> animation;

  void _updatePlaces(Set<PlaceInfo> value) {
    _list.update(value);
    setState(() {});
  }

  // Used to build list items that haven't been removed.
  Widget _buildItem(BuildContext context, int index, _) {
    return Builder(builder: (context) {
      var selected =
          context.select<PlacesProvider, PlaceInfo?>((p) => p.selectedPlace);
      final info = _list[index];
      final isSelected = selected == info;
      return PlaceCardItem(
        animation: animation,
        item: index,
        info: info,
        selected: isSelected,
        onTap: () {
          selected = isSelected ? null : info;
        },
      );
    });
  }

  // Used to build an item after it has been removed from the list. This
  // method is needed because a removed item remains visible until its
  // animation has completed (even though it's gone as far this ListModel is
  // concerned). The widget will be used by the
  // [AnimatedListState.removeItem] method's
  // [AnimatedListRemovedItemBuilder] parameter.
  Widget _buildRemovedItem(PlaceInfo info, int item, BuildContext context,
      Animation<double> animation) {
    return PlaceCardItem(
      animation: animation,
      item: item,
      info: info,
      selected: false,
      onTap: () {},
    );
  }

  /// IconButtom onPressed callback function.
  void _toggle() {
    if (!_controller.isAnimating) {
      switch (_controller.status) {
        case AnimationStatus.dismissed:
          {
            _controller.forward();
            break;
          }
        case AnimationStatus.completed:
          {
            _controller.reverse();
            break;
          }
        default:
          {
            _controller.reset();
          }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    placesSubscription = api.placeInfoStream.listen(_updatePlaces);
    _list = ListModel<PlaceInfo>(
      listKey: _listKey,
      initialItems: <PlaceInfo>[PlaceInfo()],
      removedItemBuilder: _buildRemovedItem,
    );
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );
    animation = Tween<double>(begin: -200.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0.0,
        1.0,
        curve: Curves.ease,
      ),
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    if (placesSubscription != null) {
      placesSubscription?.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text(
                'Places',
                style: TextStyle(fontSize: 26),
              ),
              expandedHeight: 40,
              centerTitle: true,
              backgroundColor: Colors.amber[900],
              leading: IconButton(
                icon: const Icon(Icons.chevron_left_sharp),
                onPressed: Navigator.of(context)?.pop,
                tooltip: 'Go Back',
                iconSize: 26.0,
              ),
              actions: [
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.forward,
                    size: 26.0,
                  ),
                  onPressed: _toggle,
                ),
              ],
            ),
            SliverAnimatedList(
              key: _listKey,
              initialItemCount: _list.length,
              itemBuilder: _buildItem,
            ),
          ],
        ),
      );
}
