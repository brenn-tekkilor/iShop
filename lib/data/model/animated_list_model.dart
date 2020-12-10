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
typedef ListModelRemovedItemBuilderFunc<T> = Widget Function(
    T? item, BuildContext context, Animation<double> animation);

/// Keeps a dart list in sync with an animated flutter list
class AnimatedListModel<T extends Object> {
  /// constructor
  AnimatedListModel(
      {@required required this.listKey,
      @required required ListModelRemovedItemBuilderFunc<T> removedItemBuilder,
      T? initialItem})
      : _items = initialItem != null ? <T>[initialItem] : <T>[],
        _removedItemBuilder = removedItemBuilder;

  /// the animated list key
  final GlobalKey<SliverAnimatedListState> listKey;
  final ListModelRemovedItemBuilderFunc<T> _removedItemBuilder;
  final List<T> _items;
  SliverAnimatedListState? get _animatedList => listKey.currentState;

  /// inserts an item into the list
  void insert(int index, T? value) {
    if (value != null) {
      _items.insert(index, value);
      _animatedList?.insertItem(index);
    }
  }

  /// add
  void add(T? value) => insert(_items.length, value);

  /// clears the list
  void clear() => _items.clear();

  /// test every value
  bool every(bool Function(T element) test) => _items.every(test);

  /// test each value
  Iterable<T> where(bool Function(T element) test) => _items.where(test);

  /// removes an item from the list and
  /// calls the removedItemBuilder function
  /// that was passed as an argument to this class's constructor
  T? removeAt(int value) {
    final T? removedItem;
    if (value < _items.length) {
      final dynamic removed = _items.removeAt(value);
      removedItem = removed is T ? removed : null;
      if (removedItem != null) {
        _animatedList?.removeItem(
          value,
          (context, animation) =>
              _removedItemBuilder(removedItem, context, animation),
        );
      }
      return removedItem;
    }
    return null;
  }

  /// remove
  T? remove(T value) {
    if (contains(value)) {
      return removeAt(indexOf(value));
    }
  }

  /// contains
  bool contains(T value) => _items.contains(value);

  /// indexOf
  int indexOf(T value) => _items.indexOf(value);

  /// gets the number of items in the list
  int get length => _items.length;

  /// returns true if there are no items in the list
  bool get isEmpty => _items.isEmpty;

  /// returns true if the list is not empty
  bool get isNotEmpty => _items.isNotEmpty;

  /// operator for indexing into the list at the class lvl
  T operator [](int index) => _items[index];
}
