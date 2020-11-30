// Keeps a Dart [List] in sync with an [AnimatedList].
//
// The [insert] and [removeAt] methods apply to both the internal list and
// the animated list that belongs to [listKey].
//
// This class only exposes as much of the Dart List API as is needed by the
// sample app. More list methods are easily added, however methods that
// mutate the list must make the same changes to the animated list in terms
// of [AnimatedListState.insertItem] and [AnimatedList.removeItem].
import 'package:flutter/material.dart';

/// removed item builder function type definition
typedef ListModelRemovedItemBuilderFunc<E> = Widget Function(
    E item, int index, BuildContext context, Animation<double> animation);

/// Keeps a dart list in sync with an animated flutter list
class AnimatedListModel<E> {
  /// constructor
  AnimatedListModel({
    @required required this.listKey,
    @required required ListModelRemovedItemBuilderFunc<E> removedItemBuilder,
    @required required Iterable<E> initialItems,
  })   : _items = List<E>.from(initialItems),
        _removedItemBuilder = removedItemBuilder;

  /// the animated list key
  final GlobalKey<SliverAnimatedListState> listKey;
  final ListModelRemovedItemBuilderFunc<E> _removedItemBuilder;
  final List<E> _items;
  SliverAnimatedListState? get _animatedList => listKey.currentState;

  /// inserts an item into the list
  void insert(int index, E value) {
    _items.insert(index, value);
    _animatedList?.insertItem(index);
  }

  /// adds all the items to the list
  void _addAll(Iterable<E> value) {
    value.forEach(_add);
  }

  void _removeAll(Iterable<E> value) => value.forEach(_remove);
  void _add(E value) {
    _items.add(value);
    _animatedList?.insertItem(_items.length - 1);
  }

  E _remove(E value) => _removeAt(_items.indexOf(value));

  /// removes an item from the list and
  /// calls the removedItemBuilder function
  /// that was passed as an argument to this class's constructor
  E _removeAt(int index) {
    final removedItem = _items[index];
    if (removedItem != null) {
      _items.removeAt(index);
      _animatedList?.removeItem(
        index,
        (context, animation) =>
            _removedItemBuilder(removedItem, index, context, animation),
      );
    }
    return removedItem;
  }

  /// clears the list and adds new values
  void update(List<E> value) {
    _removeAll(_items.where((e) => !value.contains(e)));
    _addAll(value.where((e) => !_items.contains(e)));
  }

  /// gets the number of items in the list
  int get length => _items.length;

  /// returns true if there are no items in the list
  bool get isEmpty => _items.isEmpty;

  /// operator for indexing into the list at the class lvl
  E operator [](int index) => _items[index];

  /// returns the item at the specified index of the list
  int indexOf(E item) => _items.indexOf(item);
}
