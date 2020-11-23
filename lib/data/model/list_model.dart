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

  void insert(int index, E value) {
    _items.insert(index, value);
    _animatedList?.insertItem(index);
  }

  void _add(E value) {
    _items.add(value);
    _animatedList?.insertItem(_items.length - 1);
  }

  void _clear() {
    while (_items.isNotEmpty) {
      _removeLast();
    }
  }

  void _addAll(Iterable<E> value) {
    value.forEach((e) => _add(e));
  }

  E removeAt(int index) {
    final removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList?.removeItem(
        index,
        (BuildContext context, Animation<double> animation) =>
            _removedItemBuilder(removedItem, index, context, animation),
      );
    }
    return removedItem;
  }

  E _removeLast() => removeAt(_items.length - 1);

  void update(Iterable<E> value) {
    _clear();
    _addAll(value);
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}
