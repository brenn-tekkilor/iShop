import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ishop/app/places/places_provider.dart';
import 'package:ishop/data/model/place_info.dart';
import 'package:provider/provider.dart';

class PlacesList extends StatefulWidget {
  @override
  _PlacesListState createState() => _PlacesListState();
}

class _PlacesListState extends State<PlacesList> with TickerProviderStateMixin {
  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late ListModel<PlaceInfo> _list;
  late final AnimationController _controller;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _list = ListModel<PlaceInfo>(
      listKey: _listKey,
      initialItems: <PlaceInfo>[PlaceInfo()],
      removedItemBuilder: _buildRemovedItem,
    );
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
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
    super.dispose();
  }

  void _toggle(bool value) {}
  // Used to build list items that haven't been removed.
  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return Builder(builder: (context) {
      var selected =
          context.select<PlacesProvider, PlaceInfo?>((p) => p.selectedPlace);
      final info = _list[index];
      final isSelected = selected == info;
      return CardItem(
        animation: animation,
        item: index,
        info: info,
        selected: isSelected,
        onTap: () {
          selected = isSelected ? null : info;
          /*
        setState(() {
          _selectedItem = _selectedItem == _list[index] ? null : _list[index];
        });

         */
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
  Widget _buildRemovedItem(PlaceInfo info, int item, BuildContext context) {
    return CardItem(
      animation: animation,
      item: item,
      info: info,
      selected: false,
      onTap: () {},
    );
  }

  // Insert the "next item" into the list model.
  void insert(PlaceInfo info) {
    _list.insert(_list.length, info);
  }

  // Remove the selected item from the list model.
  void remove(PlaceInfo info) {
    _list.removeAt(_list.indexOf(info));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              ExpandIcon(
                onPressed: _toggle,
                size: 26.0,
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
}

// Keeps a Dart [List] in sync with an [AnimatedList].
//
// The [insert] and [removeAt] methods apply to both the internal list and
// the animated list that belongs to [listKey].
//
// This class only exposes as much of the Dart List API as is needed by the
// sample app. More list methods are easily added, however methods that
// mutate the list must make the same changes to the animated list in terms
// of [AnimatedListState.insertItem] and [AnimatedList.removeItem].
class ListModel<E> {
  ListModel({
    required GlobalKey<SliverAnimatedListState> listKey,
    @required required dynamic removedItemBuilder,
    Iterable<E>? initialItems,
  })  : assert(removedItemBuilder != null),
        _items = List<E>.from(initialItems ?? <E>[]),
        _listKey = listKey,
        _removedItemBuilder = removedItemBuilder;

  final GlobalKey<SliverAnimatedListState> _listKey;
  final dynamic _removedItemBuilder;
  final List<E> _items;

  SliverAnimatedListState? get _animatedList => _listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList?.insertItem(index);
  }

  E removeAt(int index) {
    final removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList?.removeItem(
        index,
        (BuildContext context, Animation<double> animation) =>
            _removedItemBuilder(removedItem, context, animation),
      );
    }
    return removedItem;
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}

// Displays its integer item as 'Item N' on a Card whose color is based on
// the item's value.
//
// The card turns gray when [selected] is true. This widget's height
// is based on the [animation] parameter. It varies as the animation value
// transitions from 0.0 to 1.0.
class CardItem extends StatelessWidget {
  const CardItem({
    Key? key,
    @required required this.animation,
    @required required this.item,
    this.info = _defaultPlaceInfo,
    required this.onTap,
    this.selected = false,
  }) : super(key: key);

  final Animation<double> animation;
  final VoidCallback onTap;
  final int item;
  final PlaceInfo info;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 2.0,
        right: 2.0,
        top: 2.0,
        bottom: 0.0,
      ),
      child: Transform(
        transform: Matrix4.identity()..translate(animation.value),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.all(20),
            height: 70,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      blurRadius: 20,
                      offset: Offset.zero,
                      color: Colors.grey.withOpacity(0.5))
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 50,
                  margin: EdgeInsets.only(left: 10),
                  child: ClipRect(
                      child: Image.asset(info.logoPath, fit: BoxFit.cover)),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(info.title,
                            style: TextStyle(color: info.labelColor)),
                        Text(info.name,
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Image.asset(info.pinPath, width: 50, height: 50),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static const _defaultPlaceInfo = PlaceInfo();
}
